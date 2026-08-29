# Load zsh setopt and shell setting
for f in "${ZDOTDIR}"/conf.d/setting/*.zsh; do
    source "$f"
done

_source_zsh_config_files() {
    local source_files
    typeset -U source_files=()
    local scripts_extension=(
        $ZDOTDIR/conf.d/zshrc/plugins/*
        $ZDOTDIR/conf.d/zshrc/integrations/*
        $ZDOTDIR/conf.d/zshrc/aliases/*
        $ZDOTDIR/conf.d/zshrc/bindings/*
    )

    for scripts in "${scripts_extension[@]}"; do
        for script in $scripts; do
            source_files+=("$script")
        done
    done

    for s in $source_files; do
        [[ -f "$s" ]] && source "$s"
    done
}

_source_zsh_config_files
