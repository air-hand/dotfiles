#!/bin/bash

set -euo pipefail

command=$1

base_dir=$(git rev-parse --show-toplevel) # Please fix if necessary
target=${PWD#"$base_dir"/}

if [ "$command" == "plan" ]; then
    set +e
    tfcmt --log-level debug -var "target:${target}" plan -- terraform "$@"
    exit_code=$?
    echo "tfcmt exit code: $exit_code" >&2
    exit $exit_code
elif [ "$command" == "apply" ]; then
    set +e
    tfcmt --log-level debug -var "target:${target}" apply -- terraform "$@"
    exit_code=$?
    echo "tfcmt exit code: $exit_code" >&2
    exit $exit_code
else
    terraform "$@"
fi
