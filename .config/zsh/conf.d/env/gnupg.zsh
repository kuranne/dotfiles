if command -v gpgconf &> /dev/null; then
    export GPG_TTY=$(tty)
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    gpgconf --launch gpg-agent >/dev/null 2>&1
    gpg-connect-agent --no-autostart updatestartuptty /bye >/dev/null 2>&1
fi