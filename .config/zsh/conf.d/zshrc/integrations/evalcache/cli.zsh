# mise-en-place (shims mode for near-instant startup, no precmd hook)
if (( $+commands[mise] )); then
  _evalcache mise mise activate zsh --shims
fi

# zoxide
if (( $+commands[zoxide] )); then
  _evalcache zoxide zoxide init --cmd cd zsh
fi

# starship prompt
if (( $+commands[starship] )); then
  _evalcache starship starship init zsh
fi

# run completions
if (( $+commands[run] )); then
  _evalcache run run --completion zsh
fi
