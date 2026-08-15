# ==============================================================================
# Cli INTEREACTION SETUP
# ==============================================================================

# Helper function to cache init scripts
_evalcache() {
  local cache_file="$XDG_CACHE_HOME/zsh/evalcache_${1}.zsh"
  shift
  if [[ ! -s "$cache_file" ]]; then
    "$@" > "$cache_file"
  fi
  source "$cache_file"
}

# mise-en-place
if command -v mise > /dev/null; then
  _evalcache mise mise activate zsh
fi

# zoxide
if command -v zoxide > /dev/null; then
  _evalcache zoxide zoxide init --cmd cd zsh
fi



if command -v starship > /dev/null; then
  _evalcache starship starship init zsh
fi

if command -v atuin > /dev/null; then
  _evalcache atuin atuin init zsh
fi

if [[ -n "$GHOSTTY_RESOURCES_DIR" ]]; then
  source "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
fi

# Clean up helper
unset -f _evalcache
