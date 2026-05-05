HISTORY_IGNORE="(run-help) *"
zshaddhistory() {
    emulate -L zsh
    ## uncomment if HISTORY_IGNORE
    ## should use EXTENDED_GLOB syntax
    # setopt extendedglob
    [[ $1 != ${~HISTORY_IGNORE} ]]
}
