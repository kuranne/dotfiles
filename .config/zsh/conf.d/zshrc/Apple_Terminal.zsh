# Apple Terminal for me, must secure and no bloat, no rich function, raw.
# I use Apple Terminal to use sudo, file system config and manage upper /User directory

# Load history option
[[ -f "${ZDOTDIR}/conf.d/env/history.zsh" ]] && source "${ZDOTDIR}/conf.d/env/history.zsh" 
[[ -f "${ZDOTDIR}/conf.d/option/history.zsh" ]] && source "${ZDOTDIR}/conf.d/option/history.zsh"
# Reorder Path
[[ -f "${ZDOTDIR}/conf.d/env/paths.zsh" ]] && source "${ZDOTDIR}/conf.d/env/paths.zsh"
