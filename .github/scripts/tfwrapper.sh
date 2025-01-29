#!/bin/bash

set -euo pipefail

command=$1

base_dir=$(git rev-parse --show-toplevel) # Please fix if necessary
target=${PWD#"$base_dir"/}

TERRAGRUNT_TFPATH=${TERRAGRUNT_TFPATH:-"terraform"}

if [ "$command" == "plan" ]; then
    tfcmt -var "target:${target}" plan -- ${TERRAGRUNT_TFPATH} "$@"
elif [ "$command" == "apply" ]; then
    tfcmt -var "target:${target}" apply -- ${TERRAGRUNT_TFPATH} "$@"
else
    ${TERRAGRUNT_TFPATH} "$@"
fi
