#!/usr/bin/env bash

source lib/core.sh
source lib/packages.sh
source lib/utils.sh

NIRI_DIR="$BUILD_DIR/niri"

LOG "Installing Niri dependencies..."

install_packages \
  git base-devel pkg-config pkgconf \
  glib glib-devel \
  pipewire pipewire-devel \
  libseat-devel \
  cairo-devel \
  pango-devel \
  libdisplay-info-devel \
  libxkbcommon-devel \
  libinput-devel \
  pixman-devel \
  libdrm-devel \
  libgbm-devel \
  mesa-dri \
  libX11-devel \
  xorg-server-xwayland \
  clang llvm \
  rust cargo

ensure_dir "$BUILD_DIR"

clone_or_update_repo "https://github.com/YaLTeR/niri" "$NIRI_DIR"

cd "$NIRI_DIR"
rm -rf target

if command_exists niri; then
  LOG "Niri already installed"
  exit 0
fi

export PKG_CONFIG_PATH="/usr/lib/pkgconfig:/usr/share/pkgconfig"

LOG "Building Niri..."
cargo build --release

sudo cp target/release/niri /usr/local/bin/
