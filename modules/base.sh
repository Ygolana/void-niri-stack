#!/usr/bin/env bash
set -euo pipefail

source lib/core.sh
source lib/packages.sh

LOG "Updating system..."
sudo xbps-install -Su

LOG "Installing base system..."

install_packages \
  git curl base-devel pkg-config \
  dbus elogind \
  wayland wayland-protocols \
  mesa mesa-dri vulkan-loader \
  glib glib-devel pkgconf \
  libseat-devel \
  pipewire-devel \
  cairo-devel \
  pango-devel \
  libdisplay-info-devel \
  libxkbcommon-devel \
  libinput-devel \
  pixman-devel \
  libdrm-devel \
  eudev-libudev-devel \
  clang llvm \
  rust cargo

LOG "Enabling services..."
sudo ln -sf /etc/sv/dbus /var/service || true
sudo ln -sf /etc/sv/elogind /var/service || true

LOG "Base setup complete"
