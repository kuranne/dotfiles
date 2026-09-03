# ==============================================================================
# LOGIN SHELL (.zlogin)
# ==============================================================================
[[ -f "${ZDOTDIR}/bundle/.zlogin" ]] && source "${ZDOTDIR}/bundle/.zlogin" && return

# For zlogin, must specific for each MY_TERM
if [[ -f "${ZDOTDIR}"/conf.d/zlogin/"${MY_TERM}.zsh" ]]; then
    source "${ZDOTDIR}"/conf.d/zlogin/"${MY_TERM}.zsh"
fi
