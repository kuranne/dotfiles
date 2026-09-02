autoload -Uz copy-command _yazi_file_explorer

zle -N copy-command
bindkey '^Xc' copy-command

zle -N _yazi_file_explorer
bindkey '^Xe' _yazi_file_explorer
