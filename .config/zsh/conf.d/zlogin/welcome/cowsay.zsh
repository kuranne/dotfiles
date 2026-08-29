# Display a random cowsay with fortune
_zlogin_cowsay() {
    local animals=( $(cowsay -l | sed '1d') )
    local chosen_animal="${animals[$(( RANDOM % ${#animals[@]} + 1 ))]}"

    fortune -s | cowsay -f "$chosen_animal"
}
