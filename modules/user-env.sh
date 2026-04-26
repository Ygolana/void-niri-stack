#!/usr/bin/env bash
# modules/user-env.sh – Prepare the user environment for seatd + Wayland
set -euo pipefail
source "$(dirname "$0")/../lib/core.sh"

LOG "Setting up user environment for Niri + Noctalia…"

# 1. Add user to the _seatd group (if not already a member)
if ! groups "$USER" | grep -qw _seatd; then
    LOG "Adding $USER to _seatd group…"
    sudo usermod -aG _seatd "$USER"
else
    LOG "User already in _seatd group, skipping."
fi

# 2. Ensure XDG_RUNTIME_DIR is set every time the user logs in
PROFILE_LINE='export XDG_RUNTIME_DIR=/run/user/$UID
[ -d "$XDG_RUNTIME_DIR" ] || mkdir -p "$XDG_RUNTIME_DIR"
chmod 0700 "$XDG_RUNTIME_DIR"'

if ! grep -q "XDG_RUNTIME_DIR=/run/user" "$HOME/.profile" 2>/dev/null; then
    LOG "Adding XDG_RUNTIME_DIR setup to ~/.profile"
    echo "$PROFILE_LINE" >> "$HOME/.profile"
else
    LOG "~/.profile already contains XDG_RUNTIME_DIR setup."
fi

LOG "User environment setup complete ✔"
LOG "NOTE: You must reboot or log out completely and log back in for group changes to take effect."
