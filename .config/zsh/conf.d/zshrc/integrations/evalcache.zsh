# Helper function to cache eval
_evalcache() {
  local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/eval"
  [[ ! -d $cache_dir ]] && mkdir -p "$cache_dir"
  local cache_file="$cache_dir/evalcache_${1}.zsh"

  shift
  if [[ ! -s "$cache_file" ]]; then
    "$@" > "$cache_file"
  fi
  source "$cache_file"
}

for evalcache_files in "${ZDOTDIR}"/conf.d/zshrc/integrations/evalcache/*; do
    [[ -f "$evalcache_files" ]] && source "$evalcache_files"
done