# =========================================================
# ZINIT PLUGIN MANAGER
# =========================================================

# Set the directory where Zinit will be installed
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Automatically install Zinit if it's not already installed
if [ ! -d "$ZINIT_HOME" ]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$(dirname $ZINIT_HOME)" && command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && print -P "%F{33} %F{34}Installation successful.%f%b" || print -P "%F{160} The clone has failed.%f%b"
fi

source "${ZINIT_HOME}/zinit.zsh"


# Initialize completions before sourcing plugins so 'compdef' is available
autoload -Uz compinit
compinit -d "$ZSH_COMPDUMP"

# Load Oh My Zsh Library components
zinit snippet OMZL::key-bindings.zsh

# Load Oh My Zsh Plugins
zinit snippet OMZP::git
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose
zinit snippet OMZP::brew
zinit snippet OMZP::extract
zinit snippet OMZP::copyfile
zinit snippet OMZP::sudo
zinit snippet OMZP::tmux
zinit snippet OMZP::eza
zinit snippet OMZP::node
zinit snippet OMZP::rust

# --- ZSH Plugins ---
zinit light zsh-users/zsh-completions
zinit light hlissner/zsh-autopair
# zinit light marlonrichert/zsh-autocomplete
zinit light zsh-users/zsh-autosuggestions

# Fix autosuggestions ghost text
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(accept-line buffer-empty magic-c-enter magic-c-space)

zinit light zsh-users/zsh-syntax-highlighting # Syntax Highlight must be lastest in order to load.