# Print a customized greeting message
_zlogin_greeting() {
    local C_MAUVE="\033[38;2;203;166;247m"
    local C_TEAL="\033[38;2;148;226;213m"
    local C_TEXT="\033[38;2;205;214;244m"
    local C_RESET="\033[0m"

    printf "\n${C_MAUVE}   ${C_TEXT}Welcome back, ${C_TEAL}%s${C_RESET}!\n\n" "$USER"
}
