if [[ -n ${BREW_PREFIX} ]]; then
    PYTHON_CONFIGURE_OPTS="--with-tcltk-includes='-I${BREW_PREFIX}/opt/tcl-tk/include' --with-tcltk-libs='-L${BREW_PREFIX}/opt/tcl-tk/lib -ltcl8.6 -ltk8.6'"
fi