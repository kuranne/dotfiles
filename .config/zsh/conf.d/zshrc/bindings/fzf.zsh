if (( $+commands[fzf] )); then
    autoload -Uz fcd _fzf_cd_widget _fzf_file_no_hidden

    zle -N _fzf_file_no_hidden
    zle -N _fzf_cd_widget
    [[ -f "${ZDOTDIR}/conf.d/keybind/fzf.zsh" ]] && source "${ZDOTDIR}/conf.d/keybind/fzf.zsh"
fi
