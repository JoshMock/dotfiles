#!/usr/bin/env bash
# Runs available package security audits.
set -uo pipefail
cd "$(git rev-parse --show-toplevel)"
[ -f package-lock.json ] && npm audit
[ -f yarn.lock ] && yarn npm audit
[ -f pnpm-lock.yaml ] && pnpm audit
[ -f Cargo.lock ] && command -v cargo-audit >/dev/null && cargo audit
[ -f uv.lock ] && command -v uv >/dev/null && uv pip audit
exit 0
