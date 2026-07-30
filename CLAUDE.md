# CLAUDE.md

Personal dotfiles for macOS and Linux. No build, test, or lint step — deployment is symlinking into `$HOME`. Files in `$HOME` are symlinks into this repo, so an edit here changes the running config immediately; only a reload of the affected program is needed.

## Symlink convention

`bootstrap.sh` symlinks every **top-level** entry matching `_*` into `$HOME`, replacing only the *first* underscore with a dot:

- `_zshrc` → `~/.zshrc`
- `_aliases.darwin` → `~/.aliases.darwin`
- `_vim` → `~/.vim` (`_vim` is itself an in-repo symlink to `vimfiles/`)

- A new dotfile is deployed only if it sits at the repo root and is named `_name`. Nested files are never linked.
- Top-level dirs without the underscore (`config/`, `local/`, `scripts/`, `zsh/`, `gdb_printers/`, `vimfiles/`) are not symlinked. They are referenced by absolute path (see `ZSH_CUSTOM`), reached through another symlink (`_vim`), or copied into place by hand (`config/` and `local/` mirror `~/.config` and `~/.local` on Linux).
- `bootstrap.sh` requires GNU find; on macOS it uses `gfind` (`brew install findutils`).

## Commands

```sh
./bootstrap.sh                      # git pull + submodule update + symlink + install vim/emacs plugins
git submodule update --init --recursive
source ~/.zshrc                     # or the `reload` alias
vim +PluginInstall +qall            # Vundle plugin install
ZSH_DEBUGRC=1 zsh                   # profile zsh startup (zprof)
emacs -q -l ~/.emacs.d.old/init.el  # the `emacs_old` alias; init.el prints per-package load times
```

`bootstrap.sh` begins with `git pull`.

## Shell architecture

Layered so non-zsh shells still work:

1. `_zshenv` → sources `~/.profile`.
2. `_profile` — POSIX sh. Owns `PATH` (via the idempotent `pathmunge` helper), `GOPATH`, `MANPATH`. Shell-agnostic settings go here.
3. `_zshrc` — oh-my-zsh setup, then sources `~/.bashrc.functions` and `~/.aliases`. Tool blocks (bun, sdkman, dbt) accumulate at the bottom; **the sdkman block must stay last in the file**.
4. `_aliases` — POSIX aliases, then conditionally sources `~/.aliases.darwin` (macOS), `~/.aliases.zsh` (zsh global aliases like `L='| less'`), and `~/.aliases.local` (untracked, per-machine).

`ZSH_CUSTOM` is `$HOME/dotfiles/zsh/custom` — a hardcoded absolute path into the repo, not a symlink. oh-my-zsh auto-sources every `*.zsh` there, so `zsh/custom/worktree.zsh` and `custom.zsh` need no `source` line.

`zsh/custom/worktree.zsh` holds the `worktree` command and its zsh completion. It assumes `$BEEWORKS/bee_recon` with a `recon-platform` subdir and a `develop` base branch. Keep the completion's flag list in sync when changing subcommand flags.

`zsh/custom/dotenv.zsh` holds `dotenv` — parses `.env` files and runs a command under them via `env`, never touching the calling shell. Same convention: keep its `_dotenv_complete` flag list in sync with the option parser.

## Emacs

Two independent configs coexist:

- **`_emacs.d.old/init.el`** — the one in use. Hand-rolled, `use-package`-based, one `(use-package ...)` block per package. Load order: `site-lisp/` onto `load-path` → `custom.el` → package blocks → `local.el` last. Language servers via `eglot`; the old `lsp-mode`/`cquery` blocks are commented out, not deleted. Tree-sitter modes are guarded by `treesit-language-available-p` before `major-mode-remap-alist`.
- **`_emacs.d`** (spacemacs submodule) + **`_spacemacs.d/layers/sk-*`** — legacy, unused by the current aliases.

The `ec` / `e` aliases talk to a daemon named `emacs-old` (`emacsclient -s emacs-old`).

`local.el` and `custom.el` are untracked — the per-machine escape hatch (host paths, `mac-command-modifier`, org agenda files, API-backed packages). Machine-specific state goes in `local.el`, not `init.el`.

Ignore rules for emacs runtime state live in `_emacs.d.old/.gitignore` as root-anchored patterns (`/recentf`); add new state files there. `ielm-history.eld`, `projects`, and `projectile-bookmarks.eld` are tracked, so ordinary emacs use dirties them.

## Vim

`vimfiles/vimrc` sources `rcfiles/tiny.vim` first — the minimal, plugin-free subset usable standalone on remote machines. Basic settings go there, plugin-dependent settings in `vimrc`. `vimrc` detects restricted mode (`E145`) and `finish`es before Vundle, so it stays usable as `vim -Z`.

## Repo conventions

- Working branch is `develop`; `master` is the main branch.
- Commit subjects use an area prefix: `[emacs]`, `[zsh]`, `[git]`, `[vim]`, `[shell]`.
- `_gitconfig` is the deployed global git config; `_gitignore` is the global ignore file (`core.excludesfile`), distinct from this repo's own `.gitignore`.
