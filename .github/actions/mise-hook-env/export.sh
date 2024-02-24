#!/usr/bin/env bash

set -eo pipefail

_set_github_env() {
    local key="${1}"
    local value="${2}"
    case "${key}" in
    "PATH")
        echo "${value}" >"$GITHUB_PATH"
        ;;
    *)
        echo "${key}=${value}" >>"$GITHUB_ENV"
        ;;
    esac
}

mise-hook-env() {
    while IFS='=' read -r key value; do
        _set_github_env "${key}" "${value}"
    done < <(mise hook-env -s bash | grep -E '^export ' | sed -e 's/^export //g')
}

mise-hook-env
