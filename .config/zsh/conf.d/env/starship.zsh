if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/starship/"${MY_TERM}.toml" ]]; then
    export STARSHIP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"/starship/"${MY_TERM}.toml"
else
    export STARSHIP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"/starship/default.toml
fi
