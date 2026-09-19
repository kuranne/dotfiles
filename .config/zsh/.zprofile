# ==============================================================================
# LOGIN SHELL CONFIGURATION (.zprofile)
# ==============================================================================
[[ -f "${ZDOTDIR}/bundle/.zprofile" ]] && { source "${ZDOTDIR}/bundle/.zprofile"; return 0; }

autoload -Uz _evalcache
if [[ -x "${BREW_PREFIX}/bin/brew" ]]; then
    _evalcache brew "${BREW_PREFIX}/bin/brew" shellenv
fi

if [[ -f "${ZDOTDIR}"/conf.d/zprofile/"${MY_TERM}.zsh" ]]; then
    source "${ZDOTDIR}"/conf.d/zprofile/"${MY_TERM}.zsh"
else
    source "${ZDOTDIR}"/conf.d/zprofile/default.zsh
fi
