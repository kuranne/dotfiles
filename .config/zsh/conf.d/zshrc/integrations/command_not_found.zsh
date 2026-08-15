# ==============================================================================
# FAST COMMAND NOT FOUND HANDLER (WITH LOCAL CACHE)
# ==============================================================================

command_not_found_handler() {
  local cmd="$1"
  local found=0
  
  # 1. Skip paths (e.g., ./script or /usr/bin/something)
  if [[ "$cmd" == */* ]]; then
    echo "zsh: command not found: $cmd" >&2
    return 127
  fi

  # 2. Setup cache directory and file path
  local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/cnf_cache"
  local cache_file="$cache_dir/$cmd"
  
  # Ensure cache directory exists silently
  mkdir -p "$cache_dir" 2>/dev/null

  # 3. Check if the command was already cached
  if [[ -f "$cache_file" ]]; then
    local cached_content="$(<"$cache_file")"
    
    # "__NONE__" means we already searched brew/mise before and found nothing
    if [[ "$cached_content" != "__NONE__" ]]; then
      echo "$cached_content"
      found=1
    fi
  else
    # 4. CACHE MISS: Search in package managers
    if command -v mise >/dev/null && mise registry 2>/dev/null | awk '{print $1}' | grep -x -F -q "$cmd"; then
      # Format the output message
      local msg="zsh: command not found: $cmd\n    It can be installed via mise:\n    mise use -g $cmd"
      
      # Save to cache and print
      printf "%b\n" "$msg" > "$cache_file"
      printf "%b\n" "$msg"
      found=1

    elif command -v brew >/dev/null; then
      local txt="$(brew which-formula --explain "$cmd" 2>/dev/null)"
      if [[ -n "$txt" ]]; then
        # Save to cache and print
        echo "$txt" > "$cache_file"
        echo "$txt"
        found=1
      fi
    fi

    # 5. If not found in any package manager, cache the negative result to skip future lookups
    if [[ $found -eq 0 ]]; then
      echo "__NONE__" > "$cache_file"
    fi
  fi

  # 6. Fallback: Native Zsh Fuzzy Matching (Did you mean?)
  # We do NOT cache fuzzy matching because installed commands change frequently
  if [[ $found -eq 0 ]]; then
    echo "zsh: command not found: $cmd" >&2
    
    if [[ ${#cmd} -ge 2 && "$cmd" =~ ^[a-zA-Z0-9_-]+$ ]]; then
      zmodload zsh/parameter 2>/dev/null
      setopt localoptions EXTENDED_GLOB
      
      local err_tol=1
      [[ ${#cmd} -ge 5 ]] && err_tol=2
      
      local matches=( ${(k)commands[(I)(#i)(#a${err_tol})$cmd]} )
      matches=("${(@)matches:#$cmd}") # Remove exact match if it snuck in
      
      if (( ${#matches} > 0 )); then
        echo -e "\nDid you mean one of these?" >&2
        for m in $matches[1,3]; do
          echo "    $m" >&2
        done
      fi
    fi
  fi

  return 127
}

# Helper function to easily clear the command-not-found cache
cnf-clear-cache() {
  local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/cnf_cache"
  rm -rf "$cache_dir"
  echo "Command-not-found cache cleared!"
}