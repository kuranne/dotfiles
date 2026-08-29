# ==============================================================================
# LOGIN SHELL CONFIGURATION (.zprofile)
# ==============================================================================

if [[ -f "${ZDOTDIR}"/conf.d/zprofile/"${TERM_PROGRAM}.zsh" ]]; then
    source "${ZDOTDIR}"/conf.d/zprofile/"${TERM_PROGRAM}.zsh"
fi