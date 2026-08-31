autoload -Uz add-zsh-hook

function title_preexec() {
    local CMD="${1%% *}"
    local CURRENT_DIR="${PWD:t}"

    if [[ "$CMD" == "ssh" ]]; then
        printf "\033]0;  %s\007" "$1"
    else
        printf "\033]0;  %s (%s)\007" "$CMD" "$CURRENT_DIR"
    fi
}

function title_precmd() {
    local CURRENT_DIR="${PWD:t}"
    local TITLE="  $CURRENT_DIR"
    local BRANCH

    BRANCH=$(git branch --show-current 2>/dev/null)

    if [[ -n "$BRANCH" ]]; then
        TITLE="$TITLE   $BRANCH"
    fi

    printf "\033]0;%s\007" "$TITLE"
}

add-zsh-hook preexec title_preexec
add-zsh-hook precmd title_precmd

[[ -d "$GHOSTTY_RESOURCES_DIR" ]] && source "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
