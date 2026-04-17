#!/usr/bin/env bash

source lib/core.sh

NOCTALIA_DIR="$HOME/.config/quickshell/noctalia-shell"
TMP_FILE="$(mktemp /tmp/noctalia.XXXXXX.tar.gz)"
NIRI_CONFIG="$HOME/.config/niri/config.kdl"

LOG "Installing Noctalia..."

ensure_dir "$NOCTALIA_DIR"

curl -L -o "$TMP_FILE" \
https://github.com/noctalia-dev/noctalia-shell/releases/latest/download/noctalia-latest.tar.gz

if [ ! -s "$TMP_FILE" ]; then
  ERROR "Download failed"
  exit 1
fi

rm -rf "$NOCTALIA_DIR"
mkdir -p "$NOCTALIA_DIR"

tar -xzf "$TMP_FILE" --strip-components=1 -C "$NOCTALIA_DIR"
rm -f "$TMP_FILE"

mkdir -p "$(dirname "$NIRI_CONFIG")"
touch "$NIRI_CONFIG"

if ! grep -q "noctalia-shell" "$NIRI_CONFIG"; then
  cat <<EOF

spawn-at-startup "qs" "-c" "noctalia-shell" "--no-duplicate"
EOF >> "$NIRI_CONFIG"
fi
