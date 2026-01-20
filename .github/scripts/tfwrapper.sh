#!/bin/bash

set -euxo pipefail

command=$1

base_dir=$(git rev-parse --show-toplevel) # Please fix if necessary
target=${PWD#"$base_dir"/}

if [ "$command" == "plan" ]; then
    tfcmt --log-level debug -var "target:${target}" plan -- terraform "$@"
elif [ "$command" == "apply" ]; then
    tfcmt --log-level debug -var "target:${target}" apply -- terraform "$@"
else
    terraform "$@"
fi
