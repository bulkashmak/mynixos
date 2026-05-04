#!/usr/bin/env bash
# Bootstrap a minimal NixOS install on the thinkpad: disko-partitioned, no flake.
# Boots into a working system with ssh, networkmanager, git, and flakes enabled —
# enough to come back and `nixos-rebuild switch --flake` against the real config.
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
DISKO_NIX="$REPO/hosts/thinkpad/disko.nix"
BOOTSTRAP_NIX="$REPO/bootstrap/configuration.nix"

# 1. Partition + format + mount via disko (DESTROYS /dev/nvme0n1).
sudo nix --experimental-features "nix-command flakes" run \
  github:nix-community/disko/latest -- \
  --mode destroy,format,mount "$DISKO_NIX"

# 2. Generate hardware-configuration.nix at /mnt/etc/nixos (filesystems come from disko).
sudo nixos-generate-config --no-filesystems --root /mnt

# 3. Drop in the bootstrap config + disko.nix; overwrites the auto-generated configuration.nix.
sudo cp "$DISKO_NIX" /mnt/etc/nixos/disko.nix
sudo cp "$BOOTSTRAP_NIX" /mnt/etc/nixos/configuration.nix

# 4. Install. --no-root-passwd skips the interactive root prompt; root login stays disabled.
sudo nixos-install --no-root-passwd

echo
echo "Done. Reboot, then log in as 'bulat' with password 'nixos' and run 'passwd' to change it."
