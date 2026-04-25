#!/usr/bin/env bash
# modules/noctalia.sh – Install Noctalia shell config
set -euo pipefail
source "$(dirname "$0")/../lib/core.sh"

NOCTALIA_DIR="$HOME/.local/share/noctalia"

# Early exit if already installed
if [ -d "$NOCTALIA_DIR" ]; then
    LOG "Noctalia shell already installed — skipping"
    exit 0
fi

LOG "Installing Noctalia shell..."

clone_or_update_repo "https://github.com/noctalia-dev/noctalia-shell.git" "$NOCTALIA_DIR"

LOG "Noctalia shell installed ✔"
