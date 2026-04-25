#!/usr/bin/env bash
# modules/base.sh – Base Void Linux packages and services
set -euo pipefail
source "$(dirname "$0")/../lib/core.sh"

install_packages() {
    local pkgs=(
        # Graphics / Wayland
        mesa
        vulkan-loader mesa-vulkan-intel
        libglvnd
        wayland wayland-devel wayland-protocols
        xdg-desktop-portal xdg-desktop-portal-wlr
        seatd

        # Input / sound
        libinput
        pipewire wireplumber pipewire-pulse
        alsa-utils

        # Fonts
        noto-fonts-ttf noto-fonts-cjk noto-fonts-emoji
        fontconfig

        # Basic tools
        curl wget git
        htop neofetch

        # Compositor / shell build deps
        cmake ninja meson clang llvm
        pkg-config
        cargo rust
        rust-std
        gcc
        scdoc
        pango-devel cairo-devel
        libxkbcommon-devel
        pixman-devel
        udev-devel
        mesa-libgbm-devel
        libinput-devel
        seatd-devel
        xcb-util-wm-devel
        xcb-util-cursor-devel

        # Noctalia‑QS build deps (Qt6)
        qt6-base-devel
        qt6-declarative-devel
        qt6-wayland-devel
    )

    LOG "Installing base packages..."
    sudo xbps-install -Syu || true
    sudo xbps-install -y "${pkgs[@]}"
    LOG "Base packages installed ✔"
}

enable_services() {
    LOG "Enabling necessary services..."
    sudo ln -sf /etc/sv/dbus /var/service
    sudo ln -sf /etc/sv/seatd /var/service
    sudo ln -sf /etc/sv/pipewire /var/service
    sudo ln -sf /etc/sv/wireplumber /var/service
    sudo ln -sf /etc/sv/alsa /var/service
    LOG "Services enabled ✔"
}

install_packages
enable_services
