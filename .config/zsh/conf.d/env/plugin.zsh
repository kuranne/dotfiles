ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(accept-line buffer-empty)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Store compdef, to manage in zinit.zsh
if ! (( $+functions[compdef] )); then
    typeset -ga _deferred_compdefs
    compdef() {
        _deferred_compdefs+=("$*")
    }
fi
