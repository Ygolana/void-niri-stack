#!/usr/bin/env bash
set -euo pipefail
trap 'echo "[ERROR] Failed at line $LINENO"' ERR

INSTALL_NIRI=false
INSTALL_NOCTALIA=false
INSTALL_ALL=false

for arg in "$@"; do
  case $arg in
    --niri) INSTALL_NIRI=true ;;
    --noctalia) INSTALL_NOCTALIA=true ;;
    --all) INSTALL_ALL=true ;;
  esac
done

if [ "$INSTALL_ALL" = true ]; then
  INSTALL_NIRI=true
  INSTALL_NOCTALIA=true
fi

echo "[+] Starting Void setup..."

bash modules/base.sh
bash modules/gpu.sh

if [ "$INSTALL_NIRI" = true ]; then
  bash modules/niri.sh
fi

if [ "$INSTALL_NOCTALIA" = true ]; then
  bash modules/quickshell.sh
  bash modules/noctalia.sh
fi

echo "[✔] Installation complete"
