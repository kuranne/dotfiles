# ==============================================================================
# BINDING
# ==============================================================================

# ---------- Functions ----------

copy-command() {
    [[ -z "$BUFFER" ]] && return

    if command -v pbcopy > /dev/null; then
        print -rn -- "$BUFFER" | pbcopy
    elif command -v xclip > /dev/null; then
        print -rn -- "$BUFFER" | xclip -selection clipboard
    elif command -v wl-copy > /dev/null; then
        print -rn -- "$BUFFER" | wl-copy
    else
        zle -M "Error: No clipboard tool found (install pbcopy/xclip/wl-copy)"
        return 1
    fi

    zle -M "Copied current command to clipboard!"
}

# ---------- Public Copy ----------
C() {
    # Fetch the very last command from history
    local last_cmd=$(fc -ln -1)
    
    # If the last command exists, evaluate it and send output to clipboard
    if [[ -n "$last_cmd" ]]; then
        eval "$last_cmd" | pbcopy
        # Using the Nerd Font copy icon ( ) nf-fa-copy
        echo "  Copied output of: $last_cmd"
    fi
}

magic-c-expand() {
    # Check if the buffer ends with " C" (space + C) BUT is not exactly "C" alone
    if [[ "$BUFFER" == *" C" && "$BUFFER" != "C" ]]; then
        # Morph " C" into " | pbcopy" dynamically on the screen
        BUFFER="${BUFFER% C} | pbcopy"
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
