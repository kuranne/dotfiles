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

# ---------- Public Copy ----------
C() {
    # Fetch the very last command from history
    local last_cmd=$(fc -ln -1)

    # If the last command exists, evaluate it and send output to clipboard
    if [[ -n "$last_cmd" ]]; then
        if [[ -n "$ZSH_CLIPBOARD_CMD" ]]; then
            eval "$last_cmd | $ZSH_CLIPBOARD_CMD"
            # Using the Nerd Font copy icon ( ) nf-fa-copy
            echo "  Copied output of: $last_cmd"
        else
            echo "Error: No clipboard tool found."
        fi
    fi
}


# --- Public Copy ---
magic-c-expand() {
    # Check if the buffer ends with " C" (space + C) BUT is not exactly "C" alone
    if [[ "$BUFFER" == *" C" && "$BUFFER" != "C" ]]; then
        if [[ -n "$ZSH_CLIPBOARD_CMD" ]]; then
            # Morph " C" into " | <clipboard_cmd>" dynamically on the screen
            BUFFER="${BUFFER% C} | $ZSH_CLIPBOARD_CMD"
        fi
    fi
}

magic-c-space() {
    magic-c-expand
    zle self-insert
}

magic-c-enter() {
    magic-c-expand
    zle accept-line
}

# ---------- Yazi Explorer ----------

_yazi_file_explorer() {
  yazi
  zle reset-prompt
}

# ==============================================================================
# Keybinding
# ==============================================================================

# ---------- Vim mode
# bindkey -v

# ---------- Copy command
zle -N copy-command
bindkey '^Xc' copy-command

# ---------- Public Copy
zle -N magic-c-space
zle -N magic-c-enter

bindkey ' ' magic-c-space
bindkey '^M' magic-c-enter

# ---------- Yazi Explorer
zle -N _yazi_file_explorer
bindkey '^Xe' _yazi_file_explorer
