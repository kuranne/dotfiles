autoload -Uz copy-command _yazi_file_explorer
zle -N copy-command
zle -N _yazi_file_explorer

[[ -f "${ZDOTDIR}/conf.d/keybind/keybind.zsh" ]] && source "${ZDOTDIR}/conf.d/keybind/keybind.zsh"
