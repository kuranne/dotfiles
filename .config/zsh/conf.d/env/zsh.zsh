# Zsh Specific Environment Variables
export ZSHRC_CONF="$ZDOTDIR/conf.d/zshrc"

export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh/cache"
[[ ! -d "$ZSH_CACHE_DIR/completions" ]] && mkdir -p "$ZSH_CACHE_DIR/completions"
