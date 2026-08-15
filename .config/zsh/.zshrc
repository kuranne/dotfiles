# ==============================================================================
# INTERACTIVE SHELL CONFIGURATION (.zshrc)
# SHELL SETTING, SERVICES OPTIONS
# ==============================================================================

# --- Shell Options ---
setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT

# --- Shell History Settings ---
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

[[ ! -d "${HISTFILE:h}" ]] && mkdir -p "${HISTFILE:h}"

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# Load all environment variables
for env_file in "$ZDOTDIR"/conf.d/env/*.zsh; do
  [[ -f "$env_file" ]] && source "$env_file"
done

if [[ "$TERM_PROGRAM" != "Apple_Terminal" ]]; then 
  [[ -f "${ZDOTDIR}/conf.d/zshrc/default.zsh" ]] && source "${ZDOTDIR}/conf.d/zshrc/default.zsh"
else
  [[ -f "${ZDOTDIR}/conf.d/zshrc/AppleTerminal.zsh" ]] && source "${ZDOTDIR}/conf.d/zshrc/AppleTerminal.zsh"
fi
