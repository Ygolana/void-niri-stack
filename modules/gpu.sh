#!/usr/bin/env bash
set -e

echo "[GPU] Detecting GPU..."

GPU_INFO=$(lspci | grep -Ei 'vga|3d|display')

echo "$GPU_INFO"

if echo "$GPU_INFO" | grep -qi "intel"; then
  echo "[GPU] Intel detected"
  sudo xbps-install -y mesa intel-video-accel vulkan-loader mesa-vulkan-intel

elif echo "$GPU_INFO" | grep -qi "amd\|radeon"; then
  echo "[GPU] AMD detected"
  sudo xbps-install -y mesa mesa-vulkan-radeon xf86-video-amdgpu linux-firmware-amd

elif echo "$GPU_INFO" | grep -qi "nvidia"; then
  echo "[GPU] NVIDIA detected (using Nouveau)"
  sudo xbps-install -y mesa nouveau vulkan-loader

else
  echo "[GPU] Unknown GPU"
  sudo xbps-install -y mesa vulkan-loader
fi
