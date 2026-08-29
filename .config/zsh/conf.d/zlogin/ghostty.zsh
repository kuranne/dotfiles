for f in "${ZDOTDIR}"/conf.d/zlogin/welcome/*.zsh; do
    source "$f"
done

_zlogin_greeting
if command -v fortune &>/dev/null && command -v cowsay &>/dev/null; then
    _zlogin_cowsay
fi

echo ""