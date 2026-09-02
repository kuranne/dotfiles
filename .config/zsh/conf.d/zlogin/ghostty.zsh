autoload -Uz _zlogin_cowsay _zlogin_greeting

_zlogin_greeting
if command -v fortune &>/dev/null && command -v cowsay &>/dev/null; then
    _zlogin_cowsay
fi

echo ""
