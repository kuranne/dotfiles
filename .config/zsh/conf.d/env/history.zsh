export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
[[ ! -d "${HISTFILE:h}" ]] && mkdir -p "${HISTFILE:h}"