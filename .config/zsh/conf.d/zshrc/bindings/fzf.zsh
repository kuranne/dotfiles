# ---------- Loading Default key-binding and completions ----------
local prefixes=("$HOME/.nix-profile" "/run/current-system/sw" "/opt/homebrew" "/usr/local")
local plugins=(
  "share/fzf/key-bindings.zsh"
  "share/fzf/completion.zsh"
  "opt/fzf/shell/key-bindings.zsh"
  "opt/fzf/shell/completion.zsh"
)

for plugin in "${plugins[@]}"; do
    for prefix in "${prefixes[@]}"; do
      if [[ -f "$prefix/$plugin" ]]; then
        source "$prefix/$plugin"
        break
      fi
    done
done

# ---------- FZF Function & Binding ----------
_fzf_file_no_hidden() {
  local cmd result
  cmd="${FZF_DEFAULT_COMMAND/--hidden /}"
  result=$(eval "${cmd:-find . -type f}" | fzf --preview "$_FZF_PREVIEW_CMD") \
    && LBUFFER+="$result"  # LBUFFER is the text left of the cursor
  zle reset-prompt
}

# FZF Change Directory
fcd() {
  local dir
  dir=$(fd --type d --hidden --exclude ".git" --max-depth 4 . "${1:-.}" | fzf --preview 'eza -la --icons --group-directories-first {}')
  [[ -n "$dir" ]] && cd "$dir"
}

_fzf_cd_widget() {
  local dir
  dir=$(fd --type d --hidden --exclude ".git" --max-depth 4 . | fzf --preview 'eza -la --icons --group-directories-first {}')
  if [[ -n "$dir" ]]; then
    cd "$dir"
  fi
  zle reset-prompt
}

# ==============================================================================
# Keybinding
# ==============================================================================

zle -N _fzf_file_no_hidden
bindkey '^F' _fzf_file_no_hidden

zle -N _fzf_cd_widget
bindkey '^Xf' _fzf_cd_widget
