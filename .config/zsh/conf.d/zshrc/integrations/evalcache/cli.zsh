# mise-en-place
if command -v mise > /dev/null; then
  _evalcache mise mise activate zsh
fi

# zoxide
if command -v zoxide > /dev/null; then
  _evalcache zoxide zoxide init --cmd cd zsh
fi

# starship
if command -v starship > /dev/null; then
  _evalcache starship starship init zsh
fi

# atuin
if command -v atuin > /dev/null; then
  _evalcache atuin atuin init zsh
fi

# direnv
if command -v direnv > /dev/null; then
  _evalcache direnv direnv hook zsh
fi

if command -v brew > /dev/null; then
  _evalcache brew brew shellenv zsh
fi
