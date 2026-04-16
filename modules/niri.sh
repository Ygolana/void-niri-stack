#!/usr/bin/env bash
set -e

if ! command -v niri >/dev/null; then
  git clone https://github.com/YaLTeR/niri /tmp/niri
  cd /tmp/niri
  cargo build --release
  sudo cp target/release/niri /usr/local/bin/
fi

mkdir -p ~/.config/niri
cp -r dotfiles/niri/.config/niri/* ~/.config/niri/ 2>/dev/null || true
