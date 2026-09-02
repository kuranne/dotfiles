if command -v pbcopy >/dev/null; then
    ZSH_CLIPBOARD_CMD="pbcopy"
elif command -v xclip >/dev/null; then
    ZSH_CLIPBOARD_CMD="xclip -selection clipboard"
elif command -v wl-copy >/dev/null; then
    ZSH_CLIPBOARD_CMD="wl-copy"
fi
