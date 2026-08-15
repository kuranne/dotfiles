# Autocomplete
_autocomplete__command () {
        local ret=1
        _autocd "$@" && ret=0
        return ret
}