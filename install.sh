sudo nix --experimental-features "nix-command flakes" run \
  github:nix-community/disko/latest -- \
  --mode destroy,format,mount "hosts/thinkpad/disko.nix"

sudo nixos-generate-config --no-filesystems --root /mnt \
  --show-hardware-config >hosts/thinkpad/hardware-configuration.nix

sudo nixos-install --flake .#thinkpad \
  --option extra-substituters "https://niri.cachix.org" \
  --option extra-trusted-public-keys "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="

sudo nixos-enter --root /mnt -c 'passwd bulat'
