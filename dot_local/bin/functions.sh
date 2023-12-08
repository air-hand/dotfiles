#!/usr/bin/env bash

repo_root() {
    cd $(git rev-parse --show-toplevel)
}

on_wsl2() {
    uname -a |grep WSL2 &> /dev/null
}

is_in_container() {
    if test -f /.dockerenv; then
        return 0
    fi
    if ! test -z "${REMOTE_CONTAINERS}" || ! test -z "${CODESPACES}"; then
        return 0
    fi
    return 1
}

watch_cmd() {
    if [ $# -lt 2 ]; then
        cat << EOF
Usage

${0} .*\.txt date
${0} '.*\.(c|cc|cpp|h|hpp)$' make all

# exclude file pattern
EXCLUDE=1 ${0} '.*\.(c|cc|cpp|h|hpp)$' echo ignore_cpp_files

# debug inotify events
DEBUG=1 ${0} '.*\.(c|cc|cpp|h|hpp)$' make build

EOF
        return 1
    fi
    PATTERN="${1}"
    PATTERN_OPTION="--include ${PATTERN}"
    POST_COMMAND="${2}"

    if [ -n "${EXCLUDE}" ]; then
        PATTERN_OPTION="--exclude ${PATTERN}"
    fi

    if ! command -v inotifywait &> /dev/null; then
        sudo apt install -y inotify-tools
    fi

    inotifywait -m -e modify -e create -e delete -r $(pwd) \
        --format '%T %w%f %e' --timefmt '%FT%T' \
        $PATTERN_OPTION | \
        while read -r TIME FILEPATH EVENTS; do \
            # debug inotify events
            test ! -z $DEBUG && echo "T: ${TIME}, F: ${FILEPATH}, E: ${EVENTS}"; \
            $POST_COMMAND; \
        done
}

random_string() {
    LENGTH=${1:-32}
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $LENGTH | head -n 1
}
