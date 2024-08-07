#!/bin/bash

set -euo pipefail

command=$1

base_dir=$(git rev-parse --show-toplevel) # Please fix if necessary
target=${PWD#"$base_dir"/}

if [ "$command" == "plan" ]; then
    tfcmt -var "target:${target}" plan -- tofu "$@"
elif [ "$command" == "apply" ]; then
    tfcmt -var "target:${target}" apply -- tofu "$@"
else
    tofu "$@"
fi
