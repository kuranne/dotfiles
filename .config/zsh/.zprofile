# ==============================================================================
# LOGIN SHELL CONFIGURATION (.zprofile)
# ==============================================================================

if [[ -f "${ZDOTDIR}"/conf.d/zprofile/"${MY_TERM}.zsh" ]]; then
    source "${ZDOTDIR}"/conf.d/zprofile/"${MY_TERM}.zsh"
else
    source "${ZDOTDIR}"/conf.d/zprofile/default.zsh
fi
