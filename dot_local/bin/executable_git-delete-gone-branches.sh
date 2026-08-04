#!/usr/bin/env bash

set -euo pipefail

git prn

branches=$(git for-each-ref --format='%(refname:short) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {print $1}')
if [ -z "${branches}" ]; then
    echo 'No local branches with a deleted upstream.'
    exit 0
fi

echo 'The following local branches have a deleted upstream:'
printf '%s\n' "${branches}"
printf 'Delete all of them? [y/N] '
read -r answer
case "${answer}" in
    [yY])
        printf '%s\n' "${branches}" | xargs -I{} -r -n 1 git branch -D {}
        ;;
    *)
        echo 'Aborted.'
        ;;
esac
