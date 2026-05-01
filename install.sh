sudo nix --experimental-features "nix-command flakes" run \
  github:nix-community/disko/latest -- \
  --mode destroy,format,mount "hosts/thinkpad/disko.nix"

sudo nixos-generate-config --no-filesystems --root /mnt \
  --show-hardware-config >hosts/thinkpad/hardware-configuration.nix

sudo nixos-install --flake .#thinkpad

sudo nixos-enter --root /mnt -c 'passwd bulat'
