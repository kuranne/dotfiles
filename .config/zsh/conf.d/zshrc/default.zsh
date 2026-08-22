typeset -U path fpath
fpath=(
  $DOCKER_CONFIG/completions
  $fpath
)

typeset -U source_files=()
# Manual Scripts Extension
# These will be at the bottom in $source_files
local scripts_extension=(
  $ZSHRC_CONF/plugins/*
  $ZSHRC_CONF/integrations/*
  $ZSHRC_CONF/aliases/*
  $ZSHRC_CONF/bindings/*
)

for scripts in "${scripts_extension[@]}"; do
    for script in $scripts; do
        source_files+=("$script")
    done
done

# ---------- Emacs to Vim
bindkey -v

# Source zsh script
for s in $source_files; do
  [[ -f "$s" ]] && source "$s"
done
