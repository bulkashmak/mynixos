# Installing NixOS on `formd`

Step-by-step for a fresh install. The same shape applies to other hosts — swap `formd` for the target host and adjust the disko path.

## 0. Before unplugging the formd PC

Push this branch to your remote (or copy the repo to a USB stick), so you can pull it on the live USB:

```sh
git add -A && git commit -m "Add formd host" && git push -u origin formd-host
```

## 1. Boot the NixOS live installer

Any 25.11 (or nixos-unstable) minimal/graphical ISO. Get network up — `nmtui` works on the graphical ISO; on minimal:

```sh
sudo systemctl start NetworkManager
nmcli device wifi connect <SSID> password <pass>
```

## 2. Get the flake onto the live system

```sh
git clone https://github.com/bulkashmak/mynixos.git
cd mynixos
git checkout formd-host
```

## 3. Run disko (WIPES BOTH NVMes — nvme1n1 included)

```sh
sudo nix --experimental-features "nix-command flakes" run \
  github:nix-community/disko/latest -- \
  --mode destroy,format,mount hosts/formd/disko.nix
```

After this, `/mnt` holds the new root, `/mnt/boot` the ESP, `/mnt/mnt/data` the second-drive btrfs.

## 4. Regenerate hardware-configuration.nix from real hardware

The committed file is a placeholder. **Overwrite it:**

```sh
sudo nixos-generate-config --no-filesystems --root /mnt \
  --show-hardware-config > hosts/formd/hardware-configuration.nix
```

No `git add -N` needed — the path was already committed in step 0, so the flake will see the new content.

## 5. Install

```sh
sudo nixos-install --flake .#formd \
  --option extra-substituters "https://niri.cachix.org" \
  --option extra-trusted-public-keys "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
```

The cachix flag avoids rebuilding niri from source.

## 6. Set the user password

```sh
sudo nixos-enter --root /mnt -c 'passwd bulat'
```

## 7. Reboot

```sh
sudo reboot
```

Remove the USB. systemd-boot picks up NixOS automatically.

## 8. Post-boot one-time setup

- **Log in via tuigreet**, then start niri.
- **LACT** — open the `lact` GUI from the launcher. The daemon's already running via `systemd.services.lactd`; the GUI configures fan curves / clocks / undervolt.
- **CoolerControl** — launch `coolercontrol`. First run prompts for the systemd-managed daemon password (or auto-auths via polkit, depending on version).
- **Flatpaks** — nix-flatpak installs them on first user session via a systemd user unit. It takes a few minutes. Monitor with:
  ```sh
  systemctl --user status flatpak-managed-install.service
  ```
- **Steam** — launch from the menu. Proton-GE is already in `programs.steam.extraCompatPackages`; set Steam Play to use Proton-GE under Settings → Compatibility.

## 9. Verify monitor outputs match

If DP cables landed on different ports than when the config was captured, the connector → EDID mapping may differ. Run:

```sh
niri msg outputs
```

Update `hosts/formd/home.nix` if needed, then `./rebuild.sh`.

## Troubleshooting build failures at step 5

- `programs.coolercontrol.enable` doesn't exist in nixpkgs 25.11 → swap to a manual `systemd.services.coolercontrold` unit (mirror LACT's pattern in `modules/nixos/gaming/hardware.nix`).
- Missing kernel module in initrd → re-run `nixos-generate-config`, or add the missing module to `boot.initrd.availableKernelModules` in `hosts/formd/hardware-configuration.nix`.
