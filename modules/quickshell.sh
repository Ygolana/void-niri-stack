#!/usr/bin/env bash

source lib/core.sh
source lib/packages.sh
source lib/utils.sh

QS_DIR="$BUILD_DIR/quickshell"

LOG "Installing Quickshell dependencies..."

install_packages \
  git cmake ninja \
  qt6-base-devel \
  qt6-declarative-devel \
  qt6-wayland-devel \
  qt6-tools-devel \
  qt6-shadertools-devel \
  qt6-svg-devel

ensure_dir "$BUILD_DIR"

clone_or_update_repo "https://github.com/quickshell-mirror/quickshell" "$QS_DIR"

cd "$QS_DIR"

if command_exists quickshell; then
  LOG "Quickshell already installed — skipping"
  exit 0
fi

LOG "Hard cleaning build state..."
rm -rf build

export CC=clang
export CXX=clang++

LOG "Configuring..."
cmake -S . -B build -G Ninja \
  -DCMAKE_BUILD_TYPE=Release

LOG "Building..."
cmake --build build --parallel "$(nproc)"

LOG "Installing..."
sudo cmake --install build

if command_exists quickshell; then
  LOG "Quickshell OK ✔"
else
  ERROR "Quickshell FAILED after install"
  exit 1
fi
