#!/usr/bin/env bash
# Rebuild the flake for the current host (or one passed as $1).
set -euo pipefail
host="${1:-$(hostname)}"
sudo nixos-rebuild switch --flake ".#${host}"
