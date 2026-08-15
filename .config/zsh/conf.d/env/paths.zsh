# ==============================================================================
# PATH CONFIG ENVIRONMENT
# ==============================================================================

typeset -U path

# Add Path here:
local target_paths=(
  $XDG_BIN_HOME
  $CARGO_HOME/bin
  $GOPATH/bin
  $HOME/Library/Android/sdk/emulator
  $BREW_PREFIX/sbin
  $BREW_PREFIX/opt/openjdk/bin
  $BREW_PREFIX/opt/llvm/bin
  $BREW_PREFIX/opt/bison/bin
  $BREW_PREFIX/bin
)

local valid_paths=()
for p in $target_paths; do
  [[ -d $p ]] && valid_paths+=($p)
done

path=(
  $valid_paths
  $path
)

export PATH