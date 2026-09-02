# Load setopt and shell setting
# This should be call once on session start and only one time (assume.)
for f in "${ZDOTDIR}"/conf.d/option/*.zsh(N); do
    source "$f"
done

# This will include paths.zsh which was called, call this again to ensure paths would order in right sequence.
for f in "${ZDOTDIR}"/conf.d/env/*.zsh(N); do
    source $f
done

# Main source files function
# This function load:
#   1. all zsh file zshrc conf.d
#   2. files in source_files variable
_source_zsh_config_files() {
    local source_files

    # Put the path of files in bracket
    typeset -U source_files=(
    # ==========

    # ==========
    )

    for script in "${ZDOTDIR}"/conf.d/zshrc/{plugins,integrations,aliases,bindings,functions}/*.zsh(N); do
        source "$script"
    done

    for s in $source_files; do
        [[ -f "$s" ]] && source "$s"
    done
}

_source_zsh_config_files

unset _deferred_compdefs
