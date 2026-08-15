local integrations_zsh=(
    "cli_intereaction.zsh"
    "command_not_found.zsh"    
    "title.zsh"
)
for f in $integrations_zsh; do
    if [[ -f "${ZSHRC_CONF}/integrations/${f}" ]]; then
        source "${ZSHRC_CONF}/integrations/${f}"
    fi
done