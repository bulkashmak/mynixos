# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```sh
# Rebuild and switch for current host
./rebuild.sh

# Rebuild for a specific host
./rebuild.sh thinkpad

# Check flake for syntax errors without building
nix flake check

# Update all flake inputs
nix flake update

# Update a single input
nix flake update nixpkgs
```

## Architecture

This is a NixOS flake configuration spanning multiple hosts (currently `thinkpad` and `formd`) using **niri** (a Wayland compositor) and **home-manager**. All system and home modules are imported unconditionally; behavior diverges per host through `my.*` enable options (see "Host-opt-in bundles").

### Entry points

- `flake.nix` — declares all inputs and calls `lib/mkHost.nix` per host
- `lib/mkHost.nix` — the wiring layer: composes nixpkgs, home-manager, third-party modules (`niri-flake`, `nix-flatpak`, `disko`, `noctalia`), and the host-specific directory
- `hosts/thinkpad/` — Intel laptop. AMD-less, hibernates to swap. Sets `my.laptop.enable` and `my.dev.enable`.
- `hosts/formd/` — AMD Ryzen + AMD GPU desktop, dual 2 TB NVMes (second NVMe reserves 500 G for a future Windows install, remainder mounted at `/mnt/data`). Sets `my.gaming.enable` and `my.dev.enable`.

### Module layers

**`modules/nixos/`** — NixOS system modules, all unconditionally imported via `default.nix`:
- `core.nix` — boot, zram swap, nix settings, base packages
- `wm.nix` — enables niri + tuigreet login manager
- `desktop-base.nix` — graphics, XDG portals, GNOME keyring, printing
- `file-manager.nix` — Thunar (GTK3) + gvfs/tumbler. One of two native GUI exceptions (see "GUI apps").
- `flatpak.nix` — system-level flatpak runtime/dbus only; packages live in `modules/home/flatpak.nix`
- `laptop.nix` — thermald, libinput touchpad, `power-profiles-daemon`. Gated on `my.laptop.enable`. Don't add TLP — the two conflict.
- `gaming/` — bundle gated on `my.gaming.enable` (see "Host-opt-in bundles")
- `dev/` — bundle gated on `my.dev.enable` (see "Host-opt-in bundles")

**`modules/home/`** — home-manager modules, all unconditionally imported:
- `core.nix` — git, starship, GTK/Qt theming, cursor, claude-code package
- `terminal.nix` — Ghostty terminal (GruvboxDark, JetBrainsMono Nerd Font)
- `shell.nix` — Noctalia, the Wayland desktop shell (bar, launcher, lock, notifications) for niri
- `flatpak.nix` — declarative per-user Flatpak via `nix-flatpak` (`uninstallUnmanaged = true`, auto-updates weekly)
- `niri/` — niri config split into KDL sections (`input`, `layout`, `binds`, `window-rules`, `animations`, `misc`), assembled in `default.nix`

### Niri config extension points

The `my.niri` home-manager option (defined in `modules/home/niri/default.nix`) exposes:
- `my.niri.outputs` — raw KDL string for `output` declarations; set per-host in `hosts/<host>/home.nix`. Capture real values with `niri msg outputs` and paste them in — the output name is the EDID string, e.g. `"GIGA-BYTE TECHNOLOGY CO., LTD. M27Q X 23500B005738"`, not the connector (`DP-2`).
- `my.niri.extraConfig` — raw KDL appended at the end of the assembled config

### Host-opt-in bundles

The repo uses a consistent `my.<bundle>.enable` pattern for host-specific behavior. Modules are imported unconditionally; the option gates the actual config via `mkIf`. Existing bundles:

- `my.laptop.enable` (`modules/nixos/laptop.nix`) — thermald, PPD, libinput touchpad
- `my.gaming.enable` (`modules/nixos/gaming/`) — Steam (native, via `programs.steam.enable`), Gamescope, GameMode, MangoHud, Proton-GE, 32-bit graphics, LACT daemon (manual `systemd.services.lactd` — no top-level nixpkgs module yet), CoolerControl, `amdgpu.ppfeaturemask=0xffffffff`
- `my.dev.enable` (`modules/nixos/dev/`) — podman with `dockerCompat = true` (provides the `docker` CLI without running a second engine), Go, JDK, Node.js

**Pattern for new bundles:** create `modules/nixos/<bundle>/default.nix` with `options.my.<bundle>.enable = lib.mkEnableOption "…"` and an `imports` list of sub-modules. Each sub-module returns `lib.mkIf config.my.<bundle>.enable { … }` at the top level (no `config = …` wrapper needed when the whole file is the conditional). Hosts opt in by setting `my.<bundle>.enable = true` in `hosts/<host>/default.nix`.

**Cross-namespace reference:** home-manager modules can read NixOS options via `osConfig` because `useGlobalPkgs = true` shares the eval. Example: `modules/home/flatpak.nix` conditionally adds gaming-launcher flatpaks with `lib.optionals (osConfig.my.gaming.enable or false) [ … ]`.

### Pulling packages from nixpkgs-unstable

`nixpkgs-unstable` is wired up as a flake input for cases where a stable-channel derivation is missing or too old. To use it, instantiate it inline in the relevant module (see prior history of `modules/home/shell.nix` for the pattern) and feed the unstable derivation into the relevant `package` option, rather than upgrading the whole system to unstable.

### Flake gotcha: untracked files are invisible

Nix flakes only see git-tracked files. A new `.nix` file that isn't `git add`-ed will produce errors like `path '…/source/modules/nixos/foo.nix' does not exist`. Use `git add -N <file>` to mark it intent-to-add (visible to nix, not staged for commit).

### GUI apps

GUI applications are installed via Flatpak (`modules/home/flatpak.nix`). CLI tools and system services come from nixpkgs in the relevant module. Adding a new GUI app means adding its Flatpak ID to `services.flatpak.packages`.

Two deliberate native exceptions:
- **Thunar** (`modules/nixos/file-manager.nix`) — Flatpak sandboxing breaks the gvfs/tumbler integration (mounts, trash, thumbnails, `xdg-open`) a file manager needs. Being GTK3, Thunar also honors the home-manager `gtk.theme` / `gtk.iconTheme` set in `modules/home/core.nix`, unlike libadwaita apps.
- **Steam** (gaming bundle) — `programs.steam.enable` sets up the FHS env and 32-bit graphics drivers correctly. Heroic + Lutris stay as Flatpaks.

### Adding a new host

1. Create `hosts/<hostname>/` with `default.nix`, `home.nix`, `hardware-configuration.nix`, `disko.nix`
2. Decide which `my.*.enable` bundles apply (laptop / gaming / dev) and set them in `hosts/<hostname>/default.nix`
3. For desktops with multiple disks, follow `hosts/formd/disko.nix` — name disks `first` / `second`; reserve unformatted partitions (e.g. for a Windows install) by omitting the `content` block
4. Capture monitor outputs with `niri msg outputs` into `my.niri.outputs` in `home.nix`
5. Add an entry to the `nixosConfigurations` attrset in `flake.nix` using `mkHost`

### Bootstrap / fresh install

Use `install.sh` as reference (it's not parameterized — currently hard-codes `thinkpad`; substitute the target host when installing). Steps: run disko in `destroy,format,mount` mode, regenerate `hardware-configuration.nix` from the live USB, `nixos-install --flake .#<host>`, then `passwd <user>` via `nixos-enter`. The placeholder `hardware-configuration.nix` in each host directory is *not* a substitute for regenerating against real hardware.
