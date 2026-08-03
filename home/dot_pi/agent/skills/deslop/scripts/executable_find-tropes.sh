#!/usr/bin/env bash
# Reports likely AI comment tropes in changed files for manual review.
set -euo pipefail
here=$(cd "$(dirname "$0")" && pwd)
files=$("$here/changed-files.sh")
[ -n "$files" ] || exit 0
# ponytail: regex heuristics, agent judges each hit; no AST parsing until false positives hurt
printf '%s\n' "$files" | tr '\n' '\0' | xargs -0 rg -n --no-heading \
  -e '^\s*(//|#|--|/\*)\s*[-=*_~]{3,}' \
  -e '(?i)^\s*(//|#|--)\s*(section|utilities|helpers|types|constants|imports|exports|main|setup|teardown)\s*[:\-]?\s*$' \
  -e '(?i)\b(TODO|FIXME|XXX)\b' \
  -e '[\x{2018}\x{2019}\x{201C}\x{201D}\x{2013}\x{2014}\x{2026}\x{2192}\x{2190}\x{00A0}]' || true
