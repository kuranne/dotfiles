# ==============================================================================
# INTERACTIVE SHELL CONFIGURATION (.zshrc)
# ==============================================================================
zmodload zsh/zprof
[[ -f "${ZDOTDIR}/bundle/.zshrc" ]] && source "${ZDOTDIR}/bundle/.zshrc" && return

# Source zshrc config files
if [[ -f "${ZDOTDIR}/conf.d/zshrc/${MY_TERM}.zsh" ]]; then
    source "${ZDOTDIR}/conf.d/zshrc/${MY_TERM}.zsh"
else
    source "${ZDOTDIR}/conf.d/zshrc/default.zsh"
fi
