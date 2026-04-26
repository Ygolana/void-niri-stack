#!/usr/bin/env bash
set -euo pipefail
trap 'echo "[ERROR] Failed at line $LINENO: $BASH_COMMAND"' ERR

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
echo "[+] Mode: NIRI=$INSTALL_NIRI NOCTALIA=$INSTALL_NOCTALIA"

bash "$SCRIPT_DIR/modules/base.sh"
bash "$SCRIPT_DIR/modules/gpu.sh"

if [ "$INSTALL_NIRI" = true ]; then
  bash "$SCRIPT_DIR/modules/niri.sh"
fi

if [ "$INSTALL_NOCTALIA" = true ]; then
  bash "$SCRIPT_DIR/modules/quickshell.sh"
  bash "$SCRIPT_DIR/modules/noctalia.sh"
  bash "$SCRIPT_DIR/modules/user-env.sh"
fi

echo "[✔] Installation complete"
echo "————————————————————————————————————————"
echo "IMPORTANT: You must reboot now."
echo "After reboot, log in on a TTY (Ctrl+Alt+F2) and run: niri"
echo "Noctalia will start automatically."
echo "————————————————————————————————————————"
