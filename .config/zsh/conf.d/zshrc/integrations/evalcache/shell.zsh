# Terminal-shell integrations

if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    [[ -d "$GHOSTTY_RESOURCES_DIR" ]] && source "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
fi
