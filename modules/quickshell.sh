#!/usr/bin/env bash
set -e

if ! command -v qs >/dev/null; then
  git clone https://github.com/quickshell-mirror/quickshell /tmp/quickshell
  cd /tmp/quickshell

  cmake -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DQUICKSHELL_ENABLE_HYPRLAND=OFF \
    -DQUICKSHELL_ENABLE_WAYLAND=ON

  cmake --build build
  sudo cmake --install build
fi
