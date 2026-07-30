# Run a command with environment variables loaded from a .env file.
#
#   dotenv npm start                    # load ./.env, then exec
#   dotenv -f .env.local -f .env ./run  # earlier files lose to later ones
#   dotenv -n python app.py             # don't clobber vars already exported
#   dotenv                              # print what would be applied
#
# The variables are passed to the command via `env`; the calling shell's
# environment is never modified.
dotenv() {
    emulate -L zsh
    setopt local_options extendedglob
    zmodload -i zsh/parameter          # for $parameters, to spot exported vars

    local -a files
    local override=1

    while (( $# )); do
        case "$1" in
            -f|--file)         files+=("$2"); shift 2 ;;
            -f*)               files+=("${1#-f}"); shift ;;
            -n|--no-override)  override=0; shift ;;
            -h|--help)
                print -r -- "Usage: dotenv [-f FILE]... [-n] [--] [CMD [ARGS...]]"
                print -r -- "  -f, --file FILE    env file to read (default: .env, repeatable)"
                print -r -- "  -n, --no-override  keep values already exported in the environment"
                print -r -- "  with no CMD, print the assignments that would be applied"
                return 0 ;;
            --)                shift; break ;;
            -*)                print -u2 -r -- "dotenv: unknown option '$1'"; return 2 ;;
            *)                 break ;;
        esac
    done

    (( $#files )) || files=(.env)

    local -a assignments
    local -A seen
    local file line key val

    for file in "${files[@]}"; do
        if [[ ! -r "$file" ]]; then
            print -u2 -r -- "dotenv: cannot read '$file'"
            return 1
        fi

        while IFS= read -r line || [[ -n "$line" ]]; do
            line=${line%$'\r'}                    # tolerate CRLF files
            line=${line##[[:space:]]#}
            [[ -z "$line" || "$line" == '#'* ]] && continue
            line=${line##export[[:space:]]##}

            if [[ "$line" != [A-Za-z_][A-Za-z0-9_]#=* ]]; then
                print -u2 -r -- "dotenv: $file: skipping unparsable line: $line"
                continue
            fi

            key=${line%%=*}
            val=${line#*=}

            case "$val" in
                \'*\')  val=${val[2,-2]} ;;                    # single quotes: literal
                \"*\")  val=${val[2,-2]}                       # double quotes: unescape
                        val=${val//\\n/$'\n'}
                        val=${val//\\r/$'\r'}
                        val=${val//\\t/$'\t'}
                        val=${val//\\\"/\"}
                        val=${val//\\\\/\\} ;;
                *)      val=${val%%[[:space:]]##\#*}           # bare: drop " # comment"
                        val=${val%%[[:space:]]#} ;;
            esac

            if (( ! override )) && [[ ${parameters[$key]} == *export* ]]; then
                continue
            fi

            if [[ -n ${seen[$key]} ]]; then
                assignments[${seen[$key]}]="$key=$val"
            else
                assignments+=("$key=$val")
                seen[$key]=$#assignments
            fi
        done < "$file"
    done

    if (( $# == 0 )); then
        (( $#assignments )) && print -rl -- "${assignments[@]}"
        return 0
    fi

    command env "${assignments[@]}" "$@"
}

# ── Tab completion ────────────────────────────────────────────────────────────
_dotenv_complete() {
    _arguments -S \
        '*'{-f,--file}'[env file to read]:env file:_files' \
        '(-n --no-override)'{-n,--no-override}'[keep values already exported in the environment]' \
        '(- *)'{-h,--help}'[show usage]' \
        '(-): :_command_names -e' \
        '*:: :_normal'
}

compdef _dotenv_complete dotenv
