#!/usr/bin/env bash

repo_root() {
    cd "$(git rev-parse --show-toplevel)"
}

on_wsl2() {
    uname -a | grep WSL2 &>/dev/null
}

is_in_container() {
    cat /proc/1/cgroup | grep -q ":/docker/" 2>/dev/null \
        && return 0 \
        || return 1
}

watch_cmd() {
    if [ $# -lt 2 ]; then
        cat <<EOF
Usage

${FUNCNAME[0]} .*\.txt date
${FUNCNAME[0]} '.*\.(c|cc|cpp|h|hpp)$' make all

# exclude file pattern
EXCLUDE=1 ${FUNCNAME[0]} '.*\.(c|cc|cpp|h|hpp)$' echo ignore_cpp_files

# debug inotify events
DEBUG=1 ${FUNCNAME[0]} '.*\.(c|cc|cpp|h|hpp)$' make build

EOF
        return 1
    fi
    PATTERN="${1}"
    PATTERN_OPTION="--include ${PATTERN}"
    POST_COMMAND="${2}"

    if [ -n "${EXCLUDE}" ]; then
        PATTERN_OPTION="--exclude ${PATTERN}"
    fi

    if ! command -v inotifywait &>/dev/null; then
        sudo apt install -y inotify-tools
    fi

    inotifywait -m -e modify -e create -e delete -r $(pwd) \
        --format '%T %w%f %e' --timefmt '%FT%T' \
        $PATTERN_OPTION |
        while read -r TIME FILEPATH EVENTS; do
            # debug inotify events
            test ! -z $DEBUG && echo "T: ${TIME}, F: ${FILEPATH}, E: ${EVENTS}"
            $POST_COMMAND
        done
}

random_string() {
    LENGTH=${1:-32}
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $LENGTH | head -n 1
}

prepend() {
    if [ $# -lt 1 ]; then
        echo "Usage: echo '<string1> <string2> ...' | ${FUNCNAME[0]} <prefix>" >&2
        return 1
    fi
    local PREFIX="${1}"
    read -r STRING
    echo "${STRING}" | awk '{for(i=1; i<=NF; i++) $i="'"${PREFIX}"'"$i}1'
}

super-linter() {
    envs=(
        RUN_LOCAL=true
    )
    envs+=("$@")
    docker run --rm $(echo "${envs[@]}" | prepend '-e ') -v $(pwd):/tmp/lint ghcr.io/super-linter/super-linter:slim-latest
}
