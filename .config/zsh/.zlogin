# ==============================================================================
# LOGIN SHELL (.zlogin)
# ==============================================================================

if [[ -f "${ZDOTDIR}"/conf.d/zlogin/"${TERM_PROGRAM}.zsh" ]]; then
    source "${ZDOTDIR}"/conf.d/zlogin/"${TERM_PROGRAM}.zsh"
fi