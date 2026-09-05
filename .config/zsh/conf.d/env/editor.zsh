_set_editor() {
    local tui_editors=(
        nvim
        vim
        vi
    )
    for tedt in $tui_editors; do
        if command -v $tedt >/dev/null; then
            export EDITOR=$tedt
            export VISUAL=$tedt
            return 0
        fi
    done
}
_set_editor
unset -f _set_editor
