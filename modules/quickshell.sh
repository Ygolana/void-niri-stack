#!/usr/bin/env bash
set -euo pipefail

source lib/core.sh

if command -v quickshell >/dev/null 2>&1; then
  LOG "Quickshell already installed — skipping"
  exit 0
fi

LOG "Installing Quickshell (prebuilt)..."

TMP_DIR="$(mktemp -d)"
cd "$TMP_DIR"

curl -L -o quickshell.tar.gz \
https://github.com/quickshell-mirror/quickshell/releases/latest/download/quickshell-linux-x86_64.tar.gz

if [ ! -s quickshell.tar.gz ]; then
  ERROR "Download failed"
  exit 1
fi

tar -xzf quickshell.tar.gz

sudo cp quickshell /usr/local/bin/
sudo ln -sf /usr/local/bin/quickshell /usr/local/bin/qs

rm -rf "$TMP_DIR"

LOG "Quickshell installed ✔"
