typeset -U fpath
fpath=(
    ${ZDOTDIR}/lazy
    $BREW_PREFIX/share/zsh/site-functions
    $DOCKER_CONFIG/completions
    $fpath
)