#!/bin/bash

set -euo pipefail

command=$1

base_dir=$(git rev-parse --show-toplevel) # Please fix if necessary
target=${PWD#"$base_dir"/}

# TODO: tfcmt outputs "ERR tfcmt failed error=''" to stderr even on success (exit code 0)
if [ "$command" == "plan" ]; then
    tfcmt -var "target:${target}" plan -- terraform "$@"
elif [ "$command" == "apply" ]; then
    tfcmt -var "target:${target}" apply -- terraform "$@"
else
    terraform "$@"
fi
