#!/usr/bin/env bash

set -euo pipefail

invoking_worktree=$(git rev-parse --show-toplevel)
main_worktree=''
while IFS= read -r -d '' record; do
    case "${record}" in
        'worktree '*)
            # `git worktree list` always lists the main worktree first.
            main_worktree=${record#worktree}
            break
            ;;
    esac
done < <(git worktree list --porcelain -z)

if [ "${invoking_worktree}" != "${main_worktree}" ]; then
    echo 'git delete-gone must be run from the main worktree.' >&2
    echo "Main worktree: ${main_worktree}" >&2
    exit 1
fi

git prn

mapfile -t branches < <(git for-each-ref --format='%(refname:short) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {print $1}')
if [ "${#branches[@]}" -eq 0 ]; then
    echo 'No local branches with a deleted upstream.'
    exit 0
fi

listed_worktree=''
worktrees=()
while IFS= read -r -d '' record; do
    case "${record}" in
        'worktree '*)
            listed_worktree=${record#worktree }
            ;;
        'branch refs/heads/'*)
            branch=${record#branch refs/heads/}
            # Only linked worktrees may be removed.
            if [ "${listed_worktree}" != "${main_worktree}" ]; then
                for gone_branch in "${branches[@]}"; do
                    if [ "${branch}" = "${gone_branch}" ]; then
                        worktrees+=("${listed_worktree}")
                        break
                    fi
                done
            fi
            ;;
    esac
done < <(git worktree list --porcelain -z)

if [ "${#worktrees[@]}" -gt 0 ]; then
    echo 'The following worktrees will be removed before deleting their branches:'
    printf '%s\n' "${worktrees[@]}"
fi

echo 'The following local branches have a deleted upstream:'
printf '%s\n' "${branches[@]}"
printf 'Delete all of them? [y/N] '
read -r answer
case "${answer}" in
    [yY])
        for worktree in "${worktrees[@]}"; do
            # `--` makes a following value an operand, even if it starts with `-`.
            git worktree remove -- "${worktree}"
        done
        # Likewise, treat every branch name as an operand rather than an option.
        git branch -D -- "${branches[@]}"
        ;;
    *)
        echo 'Aborted.'
        ;;
esac
