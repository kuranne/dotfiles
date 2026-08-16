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
)

if [ -d "$BREW_PREFIX" ]; then
    local brew_paths=(
        $BREW_PREFIX/sbin
        $BREW_PREFIX/opt/openjdk/bin
        $BREW_PREFIX/opt/llvm/bin
        $BREW_PREFIX/opt/bison/bin
        $BREW_PREFIX/bin
    )
    for p in ${brew_paths[@]} ; do
        target_paths+=("$p")
    done
fi

local valid_paths=()
for p in $target_paths; do
  [[ -d $p ]] && valid_paths+=($p)
done

path=(
  $valid_paths
  $path
)

export PATH
