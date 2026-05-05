# Enable run-help

(( $+aliases[run-help] )) && unalias run-help
autoload -Uz run-help
alias help=run-help


# maven

function mvn_first_goal() {
  local -a options_with_args=(
    -b          --builder
                --color
    -D          --define
    -emp        --encrypt-master-password
    -ep         --encrypt-password
    -f          --file
    -gs         --global-settings
    -gt         --global-toolchains
    -l          --log-file
    -P          --activate-profiles
    -pl         --projects
    -rf         --resume-from
    -s          --settings
    -t          --toolchains
    -T          --threads
  )

  
  while [[ $# -gt 0 ]]; do
    local arg="$1"
    
    # Not a flag, this is the first goal
    if [[ "$arg" != -* ]]; then
      goal="$arg"
      return 0
    fi
    
    # Check if this exact flag takes an argument (handles --flag and multi-letter -pl)
    if [[ " ${options_with_args[*]} " == *" $arg "* ]]; then
      shift  # skip the flag
      shift  # skip the argument
      continue
    fi
    
    # Check for single-letter flag with attached argument (e.g., -Dvalue)
    # Only for 2-character prefixes
    if [[ ${#arg} -gt 2 ]] && [[ "${arg:0:1}" == "-" ]] && [[ ${#${arg:1:1}} -eq 1 ]]; then
      local option_prefix="${arg:0:2}"
      if [[ " ${options_with_args[*]} " == *" $option_prefix "* ]]; then
        # Argument is attached, just skip this element
        shift
        continue
      fi
    fi
    
    # Unknown flag, skip it
    shift
  done
  
  # No goal found
  goal=
  return 1 
}


run-help-mvn-or-mvnw() {
  local goal
  mvn_first_goal "${@}"
  echo "$goal"

  if [[ -n "$goal" ]]; then
    mvn -o help:describe -Dcmd=$goal -Ddetail | grep -v '[INFO]'
  else
    man mvn
  fi
}
