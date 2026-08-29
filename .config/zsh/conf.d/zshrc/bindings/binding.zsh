if command -v pbcopy >/dev/null; then
    ZSH_CLIPBOARD_CMD="pbcopy"
elif command -v xclip >/dev/null; then
    ZSH_CLIPBOARD_CMD="xclip -selection clipboard"
elif command -v wl-copy >/dev/null; then
    ZSH_CLIPBOARD_CMD="wl-copy"
fi

copy-command() {
    [[ -z "$BUFFER" ]] && return

    if [[ -n "$ZSH_CLIPBOARD_CMD" ]]; then
        eval "print -rn -- \"\$BUFFER\" | $ZSH_CLIPBOARD_CMD"
        zle -M "Copied current command to clipboard!"
    else
        zle -M "Error: No clipboard tool found (install pbcopy/xclip/wl-copy)"
        return 1
    fi
}

if [[ -n "$ZSH_CLIPBOARD_CMD" ]]; then
    alias -g C="| $ZSH_CLIPBOARD_CMD"
fi

_yazi_file_explorer() {
    yazi
    zle reset-prompt
}

zle -N copy-command
bindkey '^Xc' copy-command

zle -N _yazi_file_explorer
bindkey '^Xe' _yazi_file_explorer

