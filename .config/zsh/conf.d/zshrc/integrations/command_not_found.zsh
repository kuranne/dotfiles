typeset -g CNF_DB_PATH="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/cnf.db"

# Capture pre-existing system handler (from apt, dnf, pkgfile, PackageKit, etc.)
if (( $+functions[command_not_found_handler] )); then
    functions[_system_command_not_found_handler]=$functions[command_not_found_handler]
fi

# Fallback to system binaries if not already registered as a shell function
if (( ! $+functions[_system_command_not_found_handler] )); then
    if [[ -x /usr/libexec/pk-command-not-found ]]; then
        _system_command_not_found_handler() { /usr/libexec/pk-command-not-found "$@"; }
    elif [[ -x /usr/lib/command-not-found ]]; then
        _system_command_not_found_handler() { /usr/lib/command-not-found -- "$@"; }
    elif command -v command-not-found >/dev/null 2>&1; then
        _system_command_not_found_handler() { command-not-found "$@"; }
    fi
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

    # If cmd is script (ex. ./script), skip
    if [[ "$cmd" == */* ]]; then
        echo "zsh: cmd not found: $cmd" >&2
        return 127
    fi

    # 1. Check SQLite Cache (for fast static lookup of mise/brew)
    if [[ -f "$CNF_DB_PATH" ]]; then
        local sql_cmd="${cmd//\'/''}"
        local cached
        cached="$(sqlite3 -separator '|' "$CNF_DB_PATH" "SELECT source, message FROM cnf_cache WHERE cmd = '$sql_cmd' LIMIT 1;" 2>/dev/null)"

        if [[ -n "$cached" ]]; then
            local src="${cached%%|*}"
            local msg="${cached#*|}"

            sqlite3 "$CNF_DB_PATH" "UPDATE cnf_cache SET hit_count = hit_count + 1, updated_at = strftime('%s', 'now') WHERE cmd = '$sql_cmd';" >/dev/null 2>&1

            if [[ "$src" != "none" && -n "$msg" ]]; then
                printf "%b\n" "$msg"
                return 127
            fi
        fi
    fi

    # 2. Check mise (developer tool manager)
    if command -v mise >/dev/null 2>&1; then
        if mise registry 2>/dev/null | awk '{print $1}' | grep -x -F -q "$cmd"; then
            local msg="zsh: command not found: $cmd\n    It can be installed via mise:\n    mise use -g $cmd"
            printf "%b\n" "$msg"
            _cnf_init_db
            local sql_cmd="${cmd//\'/''}"
            local sql_msg="${msg//\'/''}"
            sqlite3 "$CNF_DB_PATH" "INSERT OR REPLACE INTO cnf_cache (cmd, source, message) VALUES ('$sql_cmd', 'mise', '$sql_msg');" >/dev/null 2>&1
            return 127
        fi
    fi

    # 3. Check brew (macOS / Linuxbrew)
    if command -v brew >/dev/null 2>&1; then
        local txt
        if txt="$(brew which-formula --explain "$cmd" 2>/dev/null)" && [[ -n "$txt" ]]; then
            echo "$txt"
            _cnf_init_db
            local sql_cmd="${cmd//\'/''}"
            local sql_msg="${txt//\'/''}"
            sqlite3 "$CNF_DB_PATH" "INSERT OR REPLACE INTO cnf_cache (cmd, source, message) VALUES ('$sql_cmd', 'brew', '$sql_msg');" >/dev/null 2>&1
            return 127
        fi
    fi

    # 4. Native Linux / OS Package Manager (PackageKit on Fedora, apt on Debian/Ubuntu, etc.)
    # Must be invoked directly in the foreground so interactive prompts ([y/N]) work cleanly
    # without subshell output capture or duplicate fallthrough.
    if (( $+functions[_system_command_not_found_handler] )); then
        _system_command_not_found_handler "$@"
        return $?
    fi

    # 5. Fallback: Native Zsh Fuzzy Matching ("Did you mean?") when no system package manager is available
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

    return 127
}
autoload -Uz cnf-clear-cache cnf-stats cnf-prune
