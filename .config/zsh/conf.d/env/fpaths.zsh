typeset -U path fpath
fpath=(
    ${ZDOTDIR}/functions
    $DOCKER_CONFIG/completions
    $fpath
)
