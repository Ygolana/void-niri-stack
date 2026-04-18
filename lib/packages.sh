#!/usr/bin/env bash
set -euo pipefail

install_packages() {
  sudo xbps-install -y "$@"
}
