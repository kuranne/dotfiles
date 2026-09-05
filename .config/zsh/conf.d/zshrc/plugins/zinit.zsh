if [ ! -d "$ZINIT_HOME" ]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$(dirname $ZINIT_HOME)" && command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && print -P "%F{33} %F{34}Installation successful.%f%b" || print -P "%F{160} The clone has failed.%f%b"
fi
source "${ZINIT_HOME}/zinit.zsh"

# -----------------------------------------------------------------------------
# Fast Completion Initialization (Pure Zsh, Zero Subshells)
# -----------------------------------------------------------------------------
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/cache"

autoload -Uz compinit
setopt extendedglob
if [[ -s "$ZSH_COMPDUMP" && -n "$ZSH_COMPDUMP"(#qN.mh-24) ]]; then
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

# -----------------------------------------------------------------------------
# Tier 1: Core Interactive Line-Editor Plugins (Turbo wait"0" lucid)
# Loads asynchronously right after the initial prompt is displayed.
# -----------------------------------------------------------------------------
zinit wait"0" blockf lucid for zsh-users/zsh-completions
zinit wait"0" lucid for \
    Aloxaf/fzf-tab \
    hlissner/zsh-autopair \
    atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    zdharma-continuum/fast-syntax-highlighting

# -----------------------------------------------------------------------------
# Tier 2: Auxiliary Oh-My-Zsh Snippets & Tools
# Key-bindings load synchronously so integrations (Atuin) take precedence.
# Plugins load asynchronously with Turbo wait"1" lucid.
# -----------------------------------------------------------------------------
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
    )

    typeset -A lib_deps=(
        [git]="OMZL::git.zsh"
    )

    typeset -A cmd_overrides=(
        [rust]="cargo"
    )

    for lib in "${libsnippets[@]}"; do
        zinit snippet "$lib"
    done

    for item in "${plugins[@]}"; do
        zinit wait"1" lucid for "$item"
    done

    for item in "${plugins_with_command[@]}"; do
        local name="${${item##*::}##*/}"
        local cmd="${cmd_overrides[$name]:-$name}"

        if (( $+commands[$cmd] )); then
            if [[ -n "${lib_deps[$name]}" ]]; then
                zinit wait"1" lucid for "${lib_deps[$name]}"
            fi
            zinit wait"1" lucid for "$item"
        fi
    done
}

_load_zinit_extensions
unfunction _load_zinit_extensions
