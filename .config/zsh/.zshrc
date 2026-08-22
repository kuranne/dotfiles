# ==============================================================================
# INTERACTIVE SHELL CONFIGURATION (.zshrc)
# ==============================================================================

# Load all environment variables
for env_file in "$ZDOTDIR"/conf.d/env/*.zsh; do
  [[ -f "$env_file" ]] && source "$env_file"
done

if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
  [[ -f "${ZDOTDIR}/conf.d/zshrc/AppleTerminal.zsh" ]] && source "${ZDOTDIR}/conf.d/zshrc/AppleTerminal.zsh"
else
  [[ -f "${ZDOTDIR}/conf.d/zshrc/default.zsh" ]] && source "${ZDOTDIR}/conf.d/zshrc/default.zsh"
fi
