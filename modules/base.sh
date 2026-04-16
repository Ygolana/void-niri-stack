#!/usr/bin/env bash
set -e

sudo xbps-install -Su

sudo xbps-install -y \
  base-devel git curl wget unzip \
  dbus seatd elogind polkit-elogind \
  mesa mesa-dri vulkan-loader \
  wayland wayland-protocols \
  wayland-devel wayland-protocols-devel \
  libxkbcommon-devel pixman-devel \
  mesa-devel vulkan-loader-devel \
  foot fuzzel brightnessctl \
  xdg-user-dirs xdg-desktop-portal \
  rust cargo cmake ninja pkg-config

sudo ln -sf /etc/sv/dbus /var/service
sudo ln -sf /etc/sv/seatd /var/service

sudo usermod -aG _seat "$USER"
