# Ensure lazy functions directory is in fpath
typeset -U fpath
if [[ -d "${ZDOTDIR:-$HOME/.config/zsh}/lazy" ]]; then
    fpath=("${ZDOTDIR:-$HOME/.config/zsh}/lazy" $fpath)
fi

autoload -Uz bundle_and_compile

# Aliases / shortcuts
alias bundle-zsh='bundle_and_compile'
alias zdotfiles-build='bundle_and_compile'
