ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$(dirname $ZINIT_HOME)" && command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && print -P "%F{33} %F{34}Installation successful.%f%b" || print -P "%F{160} The clone has failed.%f%b"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit snippet OMZL::key-bindings.zsh

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

zinit light zsh-users/zsh-completions
zinit light hlissner/zsh-autopair

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/cache"

autoload -Uz compinit
if [[ -s "$ZSH_COMPDUMP" && $(find "$ZSH_COMPDUMP" -mtime -1 2>/dev/null) ]]; then
    compinit -C -d "$ZSH_COMPDUMP"
else
    compinit -d "$ZSH_COMPDUMP"
fi

zinit cdreplay -q

zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(accept-line buffer-empty)

zinit light zsh-users/zsh-syntax-highlighting