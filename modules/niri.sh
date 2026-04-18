#!/usr/bin/env bash

source lib/core.sh
source lib/packages.sh
source lib/utils.sh

NIRI_DIR="$BUILD_DIR/niri"

LOG "Installing Niri dependencies..."

install_packages \
  git base-devel pkg-config \
  glib-devel \
  pipewire-devel \
  libseat-devel \
  cairo-devel \
  pango-devel \
  libdisplay-info-devel \
  libxkbcommon-devel \
  libinput-devel \
  pixman-devel \
  libdrm-devel \
  clang llvm \
  rust cargo

ensure_dir "$BUILD_DIR"

clone_or_update_repo "https://github.com/YaLTeR/niri" "$NIRI_DIR"

cd "$NIRI_DIR"

if command_exists niri; then
  LOG "Niri already installed"
  exit 0
fi

LOG "Building Niri..."
cargo build --release

sudo cp target/release/niri /usr/local/bin/
