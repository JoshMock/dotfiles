#!/usr/bin/env bash
# Migrate /etc/opensnitchd/domains/ from flat files to subdirectory/list structure,
# and create missing ips/ and nets/ trees.
#
# Run once with sudo after chezmoi apply. Safe to re-run (idempotent).
set -euo pipefail

BASE=/etc/opensnitchd
SRC="$(cd "$(dirname "$0")/lists" && pwd)"

migrate_domain() {
  local name="$1"
  local dest="$BASE/domains/$name"
  if [[ -f "$dest" ]]; then
    echo "  converting flat file → dir: $dest"
    local tmp; tmp=$(mktemp)
    cp "$dest" "$tmp"
    rm "$dest"
    mkdir -p "$dest"
    mv "$tmp" "$dest/list"
    chown root:root "$dest/list"
    chmod 644 "$dest/list"
  elif [[ ! -d "$dest" ]]; then
    echo "  creating dir: $dest"
    mkdir -p "$dest"
  fi
  # Overwrite list from chezmoi source
  install -m 644 -o root -g root "$SRC/domains/$name/list" "$dest/list"
  echo "  ok: $dest/list"
}

install_list() {
  local src_rel="$1"   # relative to $SRC, e.g. ips/discord/list
  local dest="$2"      # full destination path
  mkdir -p "$(dirname "$dest")"
  install -m 644 -o root -g root "$SRC/$src_rel" "$dest"
  echo "  ok: $dest"
}

echo "=== migrating domains ==="
for name in anthropic atuin cloudflare discord elastic github google matrix mise nono npm pypi slack spotify tidal; do
  migrate_domain "$name"
done

echo "=== installing ips ==="
install_list "ips/discord/list" "$BASE/ips/discord/list"

echo "=== installing nets ==="
install_list "nets/zoom/list" "$BASE/nets/zoom/list"

echo "=== setting directory permissions ==="
find "$BASE/domains" "$BASE/ips" "$BASE/nets" \
  -type d -exec chmod 755 {} + \
  -o -type f -exec chmod 644 {} +

echo "Done. Restart opensnitchd to reload:"
echo "  sudo systemctl restart opensnitchd"
