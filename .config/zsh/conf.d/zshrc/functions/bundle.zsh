# Ensure lazy functions directory is in fpath
typeset -U fpath
if [[ -d "${ZDOTDIR:-$HOME/.config/zsh}/lazy" ]]; then
    fpath=("${ZDOTDIR:-$HOME/.config/zsh}/lazy" $fpath)
fi

autoload -Uz bundle_zdotfile compile_zdotfile

bundle_and_compile() {
    local target_dir="${1:-${ZDOTDIR:-$HOME/.config/zsh}/bundle}"

    echo "==> [1/2] Bundling Zsh configurations into: $target_dir"
    bundle_zdotfile "$target_dir" || {
        echo >&2 "Error: Bundling failed!"
        return 1
    }

    echo "==> [2/2] Compiling bundled files and dotfiles with zcompile..."
    compile_zdotfile "$target_dir" || {
        echo >&2 "Error: Compilation failed!"
        return 1
    }

    echo "==> Done! Successfully bundled and compiled Zsh configurations."
}

# Aliases / shortcuts
alias bundle-zsh='bundle_and_compile'
alias zdotfiles-build='bundle_and_compile'
