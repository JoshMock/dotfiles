#!/usr/bin/env bash
# Lists files changed vs HEAD, falling back to the merge-base with the upstream branch.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
files=$(git diff --name-only --diff-filter=ACMR HEAD; git ls-files --others --exclude-standard)
if [ -z "$files" ]; then
  base=$(git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null || echo origin/main)
  files=$(git diff --name-only --diff-filter=ACMR "$(git merge-base HEAD "$base")" HEAD)
fi
printf '%s\n' "$files" | sort -u | sed '/^$/d'
