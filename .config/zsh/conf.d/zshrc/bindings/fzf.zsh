if command -v fzf >/dev/null; then
    autoload -Uz _load_fzf_conf _fzf_cd_widget _fzf_file_no_hidden
    _load_fzf_conf

    fcd() {
      local dir
      dir=$(fd --type d --hidden --exclude ".git" --max-depth 4 . "${1:-.}" | fzf --preview 'eza -la --icons --group-directories-first {}')
      [[ -n "$dir" ]] && cd "$dir"
    }

    zle -N _fzf_file_no_hidden
    zle -N _fzf_cd_widget
    [[ -f "${ZDOTDIR}/conf.d/keybind/fzf.zsh" ]] && source "${ZDOTDIR}/conf.d/keybind/fzf.zsh"
fi
