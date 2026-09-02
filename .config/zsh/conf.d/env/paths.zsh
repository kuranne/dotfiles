typeset -U path

load_paths() {
  # Add Path here:
  local target_paths=(
    $XDG_BIN_HOME
    $CARGO_HOME/bin
    $GOPATH/bin
  )
  _add_paths_to_target_paths() {
    target_paths+=("$@")
  }

  # --- OS-specific paths ---
  if [[ $(uname) == "Darwin" ]]; then
      local macos_paths=(
          $HOME/Library/Android/sdk/emulator
      )

      _add_paths_to_target_paths "${macos_paths[@]}"
  elif [[ $(uname) == "Linux" ]]; then
      local linux_paths=(
          $HOME/Android/Sdk/emulator
      )

      _add_paths_to_target_paths "${linux_paths[@]}"
  fi

  # --- Homebrew path ---
  if [ -d "$BREW_PREFIX" ]; then
      local brew_paths=(
          $BREW_PREFIX/sbin
          $BREW_PREFIX/opt/openjdk/bin
          $BREW_PREFIX/opt/llvm/bin
          $BREW_PREFIX/opt/bison/bin
          $BREW_PREFIX/bin
      )

      _add_paths_to_target_paths "${brew_paths[@]}"
  fi

  local valid_paths=()
  for p in "${target_paths[@]}"; do
    [[ -d "$p" ]] && valid_paths+=("$p")
  done

  path=(
    $valid_paths
    $path
  )

  export PATH
}

load_paths
