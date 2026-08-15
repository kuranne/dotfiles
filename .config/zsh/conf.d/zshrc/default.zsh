# ==============================================================================
# COMPLETION, FPATHs and Sourcefiles
# ==============================================================================

typeset -U path fpath
fpath=(
  $DOCKER_CONFIG/completions
  $fpath
)

typeset -U source_files=()

# Manual Scripts Extension
# These will be at the bottom in $source_files
local scripts_extension=(
  $ZSHRC_CONF/plugins/plugins.zsh
  $ZSHRC_CONF/integrations/integrations.zsh
  $ZSHRC_CONF/aliases/aliases.zsh
  $ZSHRC_CONF/bindings/binding.zsh
)

for script in "${scripts_extension[@]}"; do
  if [[ -f "$script" ]]; then
    source_files+=("$script")
  fi
done

# Source zsh script
for s in $source_files; do
  [[ -f "$s" ]] && source "$s"
done