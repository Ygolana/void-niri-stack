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
        pipewire wireplumber alsa-utils

        # Fonts
        noto-fonts-ttf noto-fonts-cjk noto-fonts-emoji
        fontconfig

        # Basic tools
        curl wget git
        htop fastfetch

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
        libinput-devel
        xcb-util-wm-devel
        xcb-util-cursor-devel

        # Noctalia‑QS build deps (Qt6)
        qt6-base-devel
        qt6-declarative-devel
        qt6-wayland-devel
        qt6-shadertools-devel
    )

    LOG "Syncing repository index..."
    sudo xbps-install -S

    LOG "Installing base packages..."
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
