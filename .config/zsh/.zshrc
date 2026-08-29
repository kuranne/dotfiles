# ==============================================================================
# INTERACTIVE SHELL CONFIGURATION (.zshrc)
# ==============================================================================

# Load all enironment variables
# and double check the path ordering in correctly
for env_file in "$ZDOTDIR"/conf.d/env/*.zsh; do
    [[ -f "$env_file" ]] && source "$env_file"
done

# Source zshrc config files
if [[ -f "${ZDOTDIR}/conf.d/zshrc/${TERM_PROGRAM}.zsh" ]]; then
    source "${ZDOTDIR}/conf.d/zshrc/${TERM_PROGRAM}.zsh"
else
    source "${ZDOTDIR}/conf.d/zshrc/default.zsh"
fi
