[[ -f "${ZDOTDIR}/conf.d/zshrc/default.zsh" ]] && source "${ZDOTDIR}/conf.d/zshrc/default.zsh"
for f in "${ZDOTDIR}/conf.d/zshrc/ghostty"/*.zsh; do
    source "$f"
done
