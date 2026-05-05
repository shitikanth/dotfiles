worktree() {
    local MAIN_REPO="$BEEWORKS/bee_recon"
    local WORKTREE_BASE="$BEEWORKS/worktree"
    local SUBDIR="recon-platform"

    _worktree_usage() {
        echo "Usage:"
        echo "  worktree                        cd to main repo subdir"
        echo "  worktree <name>                 cd to existing worktree subdir"
        echo "  worktree new <branch>           create worktree (name derived from branch)"
        echo "  worktree rm <name> [--force]    remove worktree (--force skips dirty check)"
        echo "  worktree ls                     list worktrees"
        echo "  worktree sync                   push all worktrees"
        echo "  worktree clean [--dry-run] [--unsafe]  fetch and remove worktrees with merged branches"
    }

    case "$1" in
        # ── list ──────────────────────────────────────────────────────────────
        ls|list)
            git -C "$MAIN_REPO" worktree list
            ;;

        # ── create ────────────────────────────────────────────────────────────
        new|create)
            local branch="$2"
            if [[ -z "$branch" ]]; then
                echo "worktree new: branch required" >&2
                return 1
            fi

            # Derive worktree name: strip "sk/" prefix, replace "/" with "-"
            local name="${branch#sk/}"
            name="${name//\//-}"

            local dest="$WORKTREE_BASE/$name"
            if [[ -e "$dest" ]]; then
                echo "worktree new: '$dest' already exists" >&2
                return 1
            fi

            # DWIM: check out existing branch, or create new one
            echo "Creating worktree '$name' at $dest (branch: $branch)"
            if git -C "$MAIN_REPO" rev-parse --verify "$branch" &>/dev/null; then
                git -C "$MAIN_REPO" worktree add "$dest" "$branch" || return 1
            else
                git -C "$MAIN_REPO" worktree add -b "$branch" "$dest" || return 1
            fi

            cd "$dest/$SUBDIR" || return 1
            ;;

        # ── remove ────────────────────────────────────────────────────────────
        rm|remove|delete)
            local name force=0
            for arg in "${@:2}"; do
                [[ "$arg" == "--force" ]] && force=1 || name="$arg"
            done
            if [[ -z "$name" ]]; then
                echo "worktree rm: name required" >&2
                return 1
            fi
            local dest="$WORKTREE_BASE/$name"
            if (( force )); then
                git -C "$MAIN_REPO" worktree remove --force "$dest" || return 1
            else
                git -C "$MAIN_REPO" worktree remove "$dest" || return 1
            fi
            echo "Removed worktree '$name'"
            ;;

        # ── sync ──────────────────────────────────────────────────────────────
        sync)
            local wt_branch
            for wt_path in "$WORKTREE_BASE"/*/; do
                [[ -d "$wt_path" ]] || continue
                wt_branch=$(git -C "$wt_path" rev-parse --abbrev-ref HEAD 2>/dev/null) || continue
                echo "→ ${wt_path%/} ($wt_branch)"
                git -C "$wt_path" push --set-upstream origin "$wt_branch" || echo "  push failed"
            done
            ;;

        # ── clean ─────────────────────────────────────────────────────────────
        clean)
            local unsafe=0 dry_run=0
            for arg in "${@:2}"; do
                [[ "$arg" == "--unsafe"   ]] && unsafe=1
                [[ "$arg" == "--dry-run"  ]] && dry_run=1
            done

            echo "Fetching..."
            git -C "$MAIN_REPO" fetch --prune || return 1

            # Branches whose remote tracking ref is gone (deleted on server, covers squash/rebase merges)
            local gone_branches
            gone_branches=$(git -C "$MAIN_REPO" branch -vv | awk '/: gone\]/ { print ($1 == "+" || $1 == "*") ? $2 : $1 }')

            # Branches reachable from origin/develop (covers regular merges)
            local merged_branches
            merged_branches=$(git -C "$MAIN_REPO" branch --merged "origin/develop" --format='%(refname:short)')

            local cleaned=0 wt_branch
            for wt_path in "$WORKTREE_BASE"/*/; do
                [[ -d "$wt_path" ]] || continue
                wt_branch=$(git -C "$wt_path" rev-parse --abbrev-ref HEAD 2>/dev/null) || continue
                if echo "$gone_branches" | grep -qx "$wt_branch" || echo "$merged_branches" | grep -qx "$wt_branch"; then
                    if (( dry_run )); then
                        echo "${wt_path%/} ($wt_branch)"
                        continue
                    fi
                    if (( ! unsafe )); then
                        read -r "reply?Remove worktree '${wt_path%/}' (branch '$wt_branch' merged/deleted)? [y/N] "
                        [[ "$reply" =~ ^[Yy]$ ]] || continue
                    fi
                    git -C "$MAIN_REPO" worktree remove "$wt_path" && (( cleaned++ ))
                fi
            done

            if (( dry_run )); then
                :
            elif (( cleaned == 0 )); then
                echo "Nothing to clean."
            else
                git -C "$MAIN_REPO" worktree prune
            fi
            ;;

        # ── help ──────────────────────────────────────────────────────────────
        -h|--help|help)
            _worktree_usage
            ;;

        # ── switch / default ──────────────────────────────────────────────────
        "")
            cd "$MAIN_REPO/$SUBDIR" || return 1
            ;;
        *)
            local dest="$WORKTREE_BASE/$1/$SUBDIR"
            if [[ ! -d "$dest" ]]; then
                echo "worktree: '$1' not found at $dest" >&2
                return 1
            fi
            cd "$dest" || return 1
            ;;
    esac
}

# ── Tab completion ────────────────────────────────────────────────────────────
_worktree_complete() {
    local state
    local curcontext="$curcontext"

    _arguments \
        '1: :->cmd' \
        '*: :->arg' \
        && return

    case "$state" in
        cmd)
            local worktree_names=("${(@f)$(ls -1 "$BEEWORKS/worktree" 2>/dev/null)}")
            _alternative \
                'subcommands:subcommand:((new\:create\ a\ new\ worktree rm\:remove\ a\ worktree ls\:list\ worktrees sync\:push\ all\ worktrees clean\:fetch\ and\ remove\ merged\ worktrees))' \
                "worktrees:worktree name:(${worktree_names[*]})"
            ;;

        arg)
            case "${words[2]}" in
                rm|remove|delete)
                    local names=("${(@f)$(ls -1 "$BEEWORKS/worktree" 2>/dev/null)}")
                    _alternative \
                        "worktrees:worktree name:(${names[*]})" \
                        'flags:flag:((--force\:skip\ dirty\ check))'
                    ;;
                new|create)
                    local branches=("${(@f)$(git -C "$BEEWORKS/bee_recon" branch --format='%(refname:short)' 2>/dev/null)}")
                    _values 'branch' "${branches[@]}"
                    ;;
                clean)
                    _values 'flag' '--dry-run' '--unsafe'
                    ;;
            esac
            ;;
    esac
}

compdef _worktree_complete worktree
