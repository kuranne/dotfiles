# ==============================================================================
# LOGIN SHELL (.zlogin)
# ==============================================================================

if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    local zlogin_confd=(
        greeting.zsh
        cowsay.zsh
    )

    for p in ${zlogin_confd[@]}; do
        [[ -f "$ZDOTDIR/conf.d/zlogin/$p" ]] && source "$ZDOTDIR/conf.d/zlogin/$p"
    done

    _zlogin_greeting

    if command -v fortune &>/dev/null && command -v cowsay &>/dev/null; then
        _zlogin_cowsay
    fi

    echo ""
fi
