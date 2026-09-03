typeset -g CNF_DB_PATH="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/cnf.db"

# Capture pre-existing system handler (from apt, dnf, pkgfile, etc.)
if (( $+functions[command_not_found_handler] )); then
    functions[_system_command_not_found_handler]=$functions[command_not_found_handler]
fi

_cnf_init_db() {
    [[ -f "$CNF_DB_PATH" ]] && return 0
    mkdir -p "${CNF_DB_PATH:h}" 2>/dev/null
    sqlite3 "$CNF_DB_PATH" >/dev/null 2>&1 <<'EOF'
PRAGMA journal_mode = WAL;
CREATE TABLE IF NOT EXISTS cnf_cache (
    cmd TEXT PRIMARY KEY,
    source TEXT NOT NULL,
    message TEXT,
    hit_count INTEGER DEFAULT 1,
    created_at INTEGER DEFAULT (strftime('%s', 'now')),
    updated_at INTEGER DEFAULT (strftime('%s', 'now'))
);
EOF
}

command_not_found_handler() {
    local cmd="$1"
    local found=0
    local txt=""

    # If cmd is script (ex. ./script), skip
    if [[ "$cmd" == */* ]]; then
        echo "zsh: cmd not found: $cmd" >&2
        return 127
    fi

    _cnf_init_db

    local sql_cmd="${cmd//\'/''}"

    # Check SQLite cache
    local cached
    cached="$(sqlite3 -separator '|' "$CNF_DB_PATH" "SELECT source, message FROM cnf_cache WHERE cmd = '$sql_cmd' LIMIT 1;" 2>/dev/null)"

    if [[ -n "$cached" ]]; then
        local src="${cached%%|*}"
        local msg="${cached#*|}"

        sqlite3 "$CNF_DB_PATH" "UPDATE cnf_cache SET hit_count = hit_count + 1, updated_at = strftime('%s', 'now') WHERE cmd = '$sql_cmd';" >/dev/null 2>&1

        if [[ "$src" != "none" ]]; then
            printf "%b\n" "$msg"
            found=1
        fi
    else
        # CACHE MISS: Search in package managers
        local src="none"
        local msg=""

        if command -v mise >/dev/null && mise registry 2>/dev/null | awk '{print $1}' | grep -x -F -q "$cmd"; then
            src="mise"
            msg="zsh: command not found: $cmd\n    It can be installed via mise:\n    mise use -g $cmd"
            printf "%b\n" "$msg"
            found=1
        elif command -v brew >/dev/null && txt="$(brew which-formula --explain "$cmd" 2>/dev/null)" && [[ -n "$txt" ]]; then
            src="brew"
            msg="$txt"
            echo "$msg"
            found=1

        # Fallback to existing registered system handler
        elif (( $+functions[_system_command_not_found_handler] )) && txt="$(_system_command_not_found_handler "$cmd" 2>&1)" && [[ -n "$txt" ]]; then
            src="system"
            msg="$txt"
            echo "$msg" >&2
            found=1

        # Hard fallbacks to common OS binaries if not sourced properly
        elif [[ -x /usr/lib/command-not-found ]] && txt="$(/usr/lib/command-not-found -- "$cmd" 2>&1)" && [[ -n "$txt" ]]; then
            src="apt"
            msg="$txt"
            echo "$msg" >&2
            found=1

        elif [[ -x /usr/libexec/pk-command-not-found ]] && txt="$(/usr/libexec/pk-command-not-found "$cmd" 2>&1)" && [[ -n "$txt" ]]; then
            src="dnf"
            msg="$txt"
            echo "$msg" >&2
            found=1

        elif command -v command-not-found >/dev/null && txt="$(command-not-found "$cmd" 2>&1)" && [[ -n "$txt" ]]; then
            src="generic"
            msg="$txt"
            echo "$msg" >&2
            found=1
        fi

        # Save result to SQLite cache
        local sql_msg="${msg//\'/''}"
        sqlite3 "$CNF_DB_PATH" "INSERT OR REPLACE INTO cnf_cache (cmd, source, message) VALUES ('$sql_cmd', '$src', '$sql_msg');" >/dev/null 2>&1
    fi

    # Fallback: Native Zsh Fuzzy Matching aka. Did you mean?
    if [[ $found -eq 0 ]]; then
        echo "zsh: command not found: $cmd" >&2

        if [[ ${#cmd} -ge 2 && "$cmd" =~ ^[a-zA-Z0-9_-]+$ ]]; then
            zmodload zsh/parameter 2>/dev/null
            setopt localoptions EXTENDED_GLOB

            local err_tol=1
            [[ ${#cmd} -ge 5 ]] && err_tol=2

            local matches=( ${(k)commands[(I)(#i)(#a${err_tol})$cmd]} )
            matches=("${(@)matches:#$cmd}")

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
autoload -Uz cnf-clear-cache cnf-stats cnf-prune
