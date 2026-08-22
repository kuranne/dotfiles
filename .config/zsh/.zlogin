# ==============================================================================
# LOGIN SHELL (.zlogin) - Aesthetic & Fast Edition
# ==============================================================================

# ---------- Functions ----------

# Display a random cowsay with fortune
_zlogin_cowsay() {
    local animals=( $(cowsay -l | sed '1d') )
    local chosen_animal="${animals[$(( RANDOM % ${#animals[@]} + 1 ))]}"

    fortune -s | cowsay -f "$chosen_animal"
}

# Print a customized greeting message
_zlogin_greeting() {
    local C_MAUVE="\033[38;2;203;166;247m"
    local C_TEAL="\033[38;2;148;226;213m"
    local C_TEXT="\033[38;2;205;214;244m"
    local C_RESET="\033[0m"

    printf "\n${C_MAUVE}   ${C_TEXT}Welcome back, ${C_TEAL}%s${C_RESET}!\n\n" "$USER"
}

# ---------- Execution ----------

if [[ "$TERM_PROGRAM" == "ghostty" ]]; then

    _zlogin_greeting

    if command -v fortune &>/dev/null && command -v cowsay &>/dev/null; then
        _zlogin_cowsay
    fi

    echo ""
fi
