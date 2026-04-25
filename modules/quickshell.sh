#!/usr/bin/env bash
# modules/quickshell.sh – Build and install Noctalia‑QS (the Quickshell fork required by Noctalia)
set -euo pipefail
source "$(dirname "$0")/../lib/core.sh"

if command -v qs >/dev/null 2>&1; then
    LOG "noctalia‑qs already installed — skipping"
    exit 0
fi

LOG "Building noctalia‑qs from source..."

QS_DIR="$BUILD_DIR/noctalia-qs"
clone_or_update_repo "https://github.com/noctalia-dev/noctalia-qs.git" "$QS_DIR"
cd "$QS_DIR"

cmake -GNinja -B build \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_INSTALL_PREFIX=/usr/local

ninja -C build
sudo ninja -C build install

LOG "noctalia‑qs installed successfully ✔"
