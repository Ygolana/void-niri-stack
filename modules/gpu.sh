#!/usr/bin/env bash
set -euo pipefail

source lib/core.sh

MARKER="/tmp/.gpu_installed"

if [ -f "$MARKER" ]; then
  LOG "GPU already configured — skipping"
  exit 0
fi

LOG "Detecting GPU..."

GPU_INFO=$(lspci | grep -Ei 'vga|3d|display')
echo "$GPU_INFO"

if echo "$GPU_INFO" | grep -qi "intel"; then
  LOG "Intel GPU detected"
  sudo xbps-install -y mesa intel-video-accel vulkan-loader mesa-vulkan-intel

elif echo "$GPU_INFO" | grep -qi "amd\|radeon"; then
  LOG "AMD GPU detected"
  sudo xbps-install -y mesa mesa-vulkan-radeon xf86-video-amdgpu linux-firmware-amd

elif echo "$GPU_INFO" | grep -qi "nvidia"; then
  LOG "NVIDIA GPU detected (nouveau)"
  sudo xbps-install -y mesa nouveau vulkan-loader

else
  LOG "Unknown GPU — installing safe fallback"
  sudo xbps-install -y mesa vulkan-loader
fi

touch "$MARKER"

LOG "GPU setup complete"
