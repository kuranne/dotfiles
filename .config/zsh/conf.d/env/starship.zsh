if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/vscode.toml"
else
    export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/default.toml"
fi
