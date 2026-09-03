# ==============================================================================
# LOGIN SHELL CONFIGURATION (.zprofile)
# ==============================================================================
[[ -f "${ZDOTDIR}/bundle/.zprofile" ]] && source "${ZDOTDIR}/bundle/.zprofile" && return
if [[ -f "${ZDOTDIR}"/conf.d/zprofile/"${MY_TERM}.zsh" ]]; then
    source "${ZDOTDIR}"/conf.d/zprofile/"${MY_TERM}.zsh"
else
    source "${ZDOTDIR}"/conf.d/zprofile/default.zsh
fi
