# ==============================================================================
# LOGIN SHELL (.zlogin)
# ==============================================================================

# For zlogin, must specific for each MY_TERM
if [[ -f "${ZDOTDIR}"/conf.d/zlogin/"${MY_TERM}.zsh" ]]; then
    source "${ZDOTDIR}"/conf.d/zlogin/"${MY_TERM}.zsh"
fi
