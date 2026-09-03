autoload -Uz add-zsh-hook title_preexec title_precmd

add-zsh-hook preexec title_preexec
add-zsh-hook chpwd title_precmd
title_precmd

[[ -d "$GHOSTTY_RESOURCES_DIR" ]] && source "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
