#!/usr/bin/env bash

source lib/core.sh
source lib/packages.sh

LOG "Updating system..."
sudo xbps-install -Su

LOG "Installing base system..."
install_packages \
  git curl base-devel pkg-config \
  dbus elogind \
  wayland wayland-protocols \
  mesa

LOG "Enabling services..."
sudo ln -sf /etc/sv/dbus /var/service
sudo ln -sf /etc/sv/elogind /var/service

LOG "Base setup complete"
