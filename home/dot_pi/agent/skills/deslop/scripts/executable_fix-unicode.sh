#!/usr/bin/env bash
# Replaces hard-to-type unicode punctuation with ASCII in changed text files.
set -euo pipefail
here=$(cd "$(dirname "$0")" && pwd)
"$here/changed-files.sh" | while read -r f; do
  [ -f "$f" ] || continue
  grep -Iq . "$f" || continue
  perl -CSD -i -pe 's/\x{2018}|\x{2019}/'"'"'/g; s/\x{201C}|\x{201D}/"/g; s/\x{2014}/--/g; s/\x{2013}/-/g; s/\x{2026}/.../g; s/\x{2192}/->/g; s/\x{2190}/<-/g; s/\x{00A0}/ /g; s/[ \t]+$//' "$f"
done
