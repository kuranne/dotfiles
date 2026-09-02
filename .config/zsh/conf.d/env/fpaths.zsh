typeset -U fpath
fpath=(
    ${ZDOTDIR}/lazy
    $DOCKER_CONFIG/completions
    $fpath
)
