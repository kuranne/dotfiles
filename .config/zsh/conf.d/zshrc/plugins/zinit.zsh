_load_zinit_extensions() {
    local libsnippets=(
        OMZL::key-bindings.zsh
    )

    local plugins=(
        OMZP::extract
        OMZP::copyfile
    )

    local plugins_with_command=(
        OMZP::brew
        OMZP::docker
        OMZP::docker-compose
        OMZP::eza
        OMZP::git
        OMZP::node
        OMZP::rust
        OMZP::sudo
        Aloxaf/fzf-tab
    )

    typeset -A lib_deps=(
        [git]="OMZL::git.zsh"
    )

    typeset -A cmd_overrides=(
        [rust]="cargo"
        [fzf-tab]="fzf"
    )

    _zinit_load() {
        local target="$1"
        if [[ "$target" == *"::"* || "$target" == https://* || "$target" == http://* ]]; then
            zinit snippet "$target"
        else
            zinit light "$target"
        fi
    }

    for lib in "${libsnippets[@]}"; do
        _zinit_load "$lib"
    done

    for item in "${plugins[@]}"; do
        _zinit_load "$item"
    done

    for item in "${plugins_with_command[@]}"; do
        local name="${${item##*::}##*/}"

        local cmd="${cmd_overrides[$name]:-$name}"

        if (( $+commands[$cmd] )); then
            # Load library dependency if mapped
            if [[ -n "${lib_deps[$name]}" ]]; then
                _zinit_load "${lib_deps[$name]}"
            fi

            _zinit_load "$item"
        fi
    done

    unfunction _zinit_load
}

if [ ! -d "$ZINIT_HOME" ]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$(dirname $ZINIT_HOME)" && command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && print -P "%F{33} %F{34}Installation successful.%f%b" || print -P "%F{160} The clone has failed.%f%b"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-completions

_load_zinit_extensions

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/cache"

autoload -Uz compinit
if [[ -s "$ZSH_COMPDUMP" && $(find "$ZSH_COMPDUMP" -mtime -1 2>/dev/null) ]]; then
    compinit -C -d "$ZSH_COMPDUMP"
else
    compinit -d "$ZSH_COMPDUMP"
fi

if (( ${#_deferred_compdefs[@]} )); then
    for cd_cmd in "${_deferred_compdefs[@]}"; do
        eval "compdef $cd_cmd"
    done
fi

zinit cdreplay -q

zinit light hlissner/zsh-autopair
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
