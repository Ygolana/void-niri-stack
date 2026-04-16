#!/usr/bin/env bash
set -e

mkdir -p ~/.config/quickshell/noctalia-shell

TMP_FILE="/tmp/noctalia.tar.gz"

curl -L -o "$TMP_FILE" \
https://github.com/noctalia-dev/noctalia-shell/releases/latest/download/noctalia-latest.tar.gz

tar -xzf "$TMP_FILE" \
  --strip-components=1 \
  -C ~/.config/quickshell/noctalia-shell

CONFIG="$HOME/.config/niri/config.kdl"

if ! grep -q "noctalia-shell" "$CONFIG" 2>/dev/null; then
cat <<EOF >> "$CONFIG"

spawn-at-startup "qs" "-c" "noctalia-shell" "--no-duplicate"
EOF
fi
