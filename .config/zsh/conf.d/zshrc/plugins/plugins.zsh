plugins_zsh=(
    "zinit.zsh"
    "fix_zinit_plugin.zsh"
    "fzf.zsh"    
)
for f in $plugins_zsh; do
    if [[ -f "${ZSHRC_CONF}/plugins/${f}" ]]; then
        source "${ZSHRC_CONF}/plugins/${f}"
    fi
done