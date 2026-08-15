# ==============================================================================
# FUNCTIONS & ALIASES
# ==============================================================================

# --- Global Command Replacements & Previews ---

local aliases_zsh=(
    "passc.zsh"
)
for f in $aliases_zsh; do
    if [[ -f "${ZSHRC_CONF}/aliases/${f}" ]]; then
        source "${ZSHRC_CONF}/aliases/${f}"
    fi
done

# eza (Modern ls replacement)
if command -v eza > /dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias l='ls'
  alias ll='ls -l'
  alias la='ls -la'
  alias tree='ls -T'
fi

# fzf (Fuzzy finder integrated with previewer)

if command -v bat > /dev/null; then
  alias f="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
else
  alias f="fzf --preview 'cat {}'"
fi

# Wrapper for history command to support -c option to clear history.
unalias history 2>/dev/null
function history() {
    local clear list
    zparseopts -E c=clear l=list

    if [[ -n "$clear" ]]; then
        echo -n >| "$HISTFILE"
        fc -p "$HISTFILE"
        echo >&2 "History cleared. Reload session to take effect."
    elif [[ -n "$list" ]]; then
        builtin fc "$@"
    else
        [[ ${@[-1]-} = *[0-9]* ]] && builtin fc -l "$@" || builtin fc -l "$@" 1
    fi
}

# Quick Directory Navigation
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Dotfiles

alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'