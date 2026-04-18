#!/usr/bin/env bash
set -euo pipefail

LOG() { echo -e "\033[1;32m[INFO]\033[0m $*"; }
WARN() { echo -e "\033[1;33m[WARN]\033[0m $*"; }
ERROR() { echo -e "\033[1;31m[ERROR]\033[0m $*"; }

BUILD_DIR="${BUILD_DIR:-$HOME/build/niri-stack}"

ensure_dir() { mkdir -p "$1"; }

clone_or_update_repo() {
  local url="$1"
  local dir="$2"

  if [ -d "$dir/.git" ]; then
    LOG "Updating repo: $dir"
    git -C "$dir" pull --rebase --autostash
  else
    LOG "Cloning: $url"
    rm -rf "$dir"
    git clone "$url" "$dir"
  fi
}
