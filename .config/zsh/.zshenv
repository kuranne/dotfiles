# ==============================================================================
# ENVIRONMENT VARIABLES (.zshenv)
# ==============================================================================

# --- System & Tool Environment Variables ---
export LANG="en_US.UTF-8"

# ---------- XDG base directories ----------
# Centralizes config/cache/data locations
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"

# ---------- XDG compliance overrides ----------

# --- zsh
[[ ! -d "$XDG_CACHE_HOME/zsh" ]] && mkdir -p "$XDG_CACHE_HOME/zsh"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# --- Lang
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export BUN_INSTALL="$XDG_DATA_HOME/bun"
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"

export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export MYPY_CACHE_DIR="$XDG_CACHE_HOME/.mypy_cache"

export MPLCONFIGDIR="$XDG_CONFIG_HOME/matplotlib"

export GOPATH="$XDG_DATA_HOME/go"

export MONO_REGISTRY_PATH="$XDG_CONFIG_HOME/mono/registry"

# --- App
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"

export ZSH_TMUX_CONF="$XDG_CONFIG_HOME/tmux/tmux.conf"

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export COLIMA_HOME="$XDG_DATA_HOME/colima"

export OLLAMA_HOME="$XDG_DATA_HOME/ollama"
export OLLAMA_MODELS="$XDG_DATA_HOME/ollama/models"

export VSCODE_EXTENSIONS="$XDG_DATA_HOME/vscode/extensions"

export LLDBINIT="$XDG_CONFIG_HOME/lldb/lldbinit"

export SWIFTPM_CACHE_DIR="$XDG_CACHE_HOME/swiftpm"
export SWIFTPM_CONFIG_DIR="$XDG_CONFIG_HOME/swiftpm"

export ANDROID_USER_HOME="$XDG_CONFIG_HOME/android"
export ANDROID_EMULATOR_HOME="$XDG_CONFIG_HOME/android"
export ANDROID_AVD_HOME="$XDG_DATA_HOME/android/avd"

export ATUIN_CONFIG_DIR="$XDG_CONFIG_HOME/atuin"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

export CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/claude"

# ---------- Editor ----------
export EDITOR="nvim"
export VISUAL="vim"

# ---------- Other ----------
# Homebrew prefix
if [[ -d "/opt/homebrew" ]]; then
    export BREW_PREFIX="/opt/homebrew"
elif [[ -x "/usr/local/bin/brew" ]]; then
    export BREW_PREFIX="/usr/local"
elif [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
    export BREW_PREFIX="/home/linuxbrew/.linuxbrew"
elif [[ -d "/opt/linuxbrew/.linuxbrew" ]]; then
    export BREW_PREFIX="/opt/linuxbrew/.linuxbrew"
fi
