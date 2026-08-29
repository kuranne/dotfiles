if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/starship/"${TERM_PROGRAM}.toml" ]]; then
    export STARSHIP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"/starship/"${TERM_PROGRAM}.toml"
else
    export STARSHIP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"/starship/default.toml
fi
