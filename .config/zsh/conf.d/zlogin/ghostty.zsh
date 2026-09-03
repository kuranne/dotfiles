autoload -Uz _zlogin_cowsay _zlogin_greeting

local stamp_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ ! -d "$stamp_dir" ]] && mkdir -p "$stamp_dir"
local stamp_file="$stamp_dir/last_zlogin_date"

local today="$(date '+%Y-%m-%d')"
if [[ ! -f "$stamp_file" || "$(<"$stamp_file")" != "$today" ]]; then
    print -r -- "$today" > "$stamp_file"
    autoload -Uz _zlogin_cowsay _zlogin_greeting
    _zlogin_greeting
    if command -v fortune &>/dev/null && command -v cowsay &>/dev/null; then
        _zlogin_cowsay
    fi
    echo ""
fi
