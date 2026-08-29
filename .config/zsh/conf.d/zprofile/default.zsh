# --- Homebrew / Compilers Environment ---
if [[ -x "${BREW_PREFIX}/bin/brew" ]]; then
    brew_prefix_tcl="${BREW_PREFIX}/opt/tcl-tk"
    export LDFLAGS="-L${brew_prefix_tcl}/lib $LDFLAGS"
    export CPPFLAGS="-I${brew_prefix_tcl}/include $CPPFLAGS"
    export PKG_CONFIG_PATH="${brew_prefix_tcl}/lib/pkgconfig:$PKG_CONFIG_PATH"
fi