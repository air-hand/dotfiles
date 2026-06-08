#!/usr/bin/env bash

set -u

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/bash-completion/generated"
mkdir -p "$cache_dir"

# This script pre-generates expensive bash completions for shell startup.
# Run it manually after updating tools, or remove $cache_dir and run it again
# to rebuild all generated completion files.

make_tmp() {
    mktemp "$cache_dir/.${1}.XXXXXX"
}

generate() {
    local name="$1"
    shift

    if ! command -v "$1" >/dev/null 2>&1; then
        rm -f "$cache_dir/$name.bash"
        return 0
    fi

    local tmp
    tmp="$(make_tmp "$name")"
    if "$@" >"$tmp"; then
        mv -f "$tmp" "$cache_dir/$name.bash" || rm -f "$tmp"
    else
        rm -f "$tmp"
        return 0
    fi
}

generate mise mise completion bash
generate aqua aqua completion bash
generate argocd argocd completion bash
generate podman podman completion bash
generate tenv tenv completion bash
generate gh gh completion -s bash
generate kubectl kubectl completion bash
generate helm helm completion bash
generate helmfile helmfile completion bash
generate kustomize kustomize completion bash
generate rustup rustup completions bash
generate rustup-cargo rustup completions bash cargo
