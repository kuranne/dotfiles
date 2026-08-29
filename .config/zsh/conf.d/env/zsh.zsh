export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/cache"
[[ ! -d "$ZSH_CACHE_DIR/completions" ]] && mkdir -p "$ZSH_CACHE_DIR/completions"

export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
[[ ! -d "${HISTFILE:h}" ]] && mkdir -p "${HISTFILE:h}"
