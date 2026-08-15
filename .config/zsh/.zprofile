# ==============================================================================
# LOGIN SHELL CONFIGURATION (.zprofile)
# ==============================================================================

# Separate Apple Terminal out from others
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]];then
    export SHELL_SESSIONS_DISABLE=1
fi

# --- Homebrew / Compilers Environment ---
if [[ -x "${BREW_PREFIX}/bin/brew" ]]; then
    eval "$("$BREW_PREFIX/bin/brew" shellenv)"
fi

brew_prefix_tcl="${BREW_PREFIX}/opt/tcl-tk"
if [[ -n "$brew_prefix_tcl" ]]; then
    export LDFLAGS="-L$brew_prefix_tcl/lib $LDFLAGS"
    export CPPFLAGS="-I$brew_prefix_tcl/include $CPPFLAGS"
    export PKG_CONFIG_PATH="$brew_prefix_tcl/lib/pkgconfig:$PKG_CONFIG_PATH"
fi

export GPG_TTY=$(tty)
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1

# ---------- Emasc to Vim
bindkey -v