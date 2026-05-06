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

This is a NixOS flake configuration for a single host (`thinkpad`) using **niri** (a Wayland compositor) and **home-manager**.

### Entry points

- `flake.nix` — declares all inputs and calls `lib/mkHost.nix` per host
- `lib/mkHost.nix` — the wiring layer: composes nixpkgs, home-manager, third-party modules (`niri-flake`, `nix-flatpak`, `disko`, `dms`), and the host-specific directory
- `hosts/thinkpad/` — hardware config, disko partition layout, and per-host home settings (monitor outputs)

### Module layers

**`modules/nixos/`** — NixOS system modules, all unconditionally imported via `default.nix`:
- `core.nix` — boot, zram swap, nix settings, base packages
- `wm.nix` — enables niri + tuigreet login manager
- `desktop-base.nix` — graphics, XDG portals, GNOME keyring, printing
- `flatpak.nix` — system-level flatpak runtime/dbus only; packages live in `modules/home/flatpak.nix`
- `laptop.nix` — thermald, libinput touchpad. Power profiles are managed by `power-profiles-daemon` (enabled by DMS), not TLP — the two conflict.

**`modules/home/`** — home-manager modules, all unconditionally imported:
- `core.nix` — git, starship, GTK/Qt theming, cursor, claude-code package
- `terminal.nix` — Ghostty terminal (GruvboxDark, JetBrainsMono Nerd Font)
- `shell.nix` — DankMaterialShell (DMS), the Wayland desktop shell (bar, launcher, lock, notifications) for niri
- `flatpak.nix` — declarative per-user Flatpak via `nix-flatpak` (`uninstallUnmanaged = true`, auto-updates weekly)
- `niri/` — niri config split into KDL sections (`input`, `layout`, `binds`, `window-rules`, `animations`, `misc`), assembled in `default.nix`

### Niri config extension points

The `my.niri` home-manager option (defined in `modules/home/niri/default.nix`) exposes:
- `my.niri.outputs` — raw KDL string for `output` declarations; set per-host in `hosts/<host>/home.nix`
- `my.niri.extraConfig` — raw KDL appended at the end of the assembled config

### Pulling packages from nixpkgs-unstable

Some DMS dependencies (e.g. `dgop`) aren't in nixpkgs 25.11. The pattern in `modules/home/shell.nix` instantiates `nixpkgs-unstable` inline and feeds the unstable derivation into the relevant DMS option (`programs.dank-material-shell.<thing>.package`). Repeat that pattern for any further missing-on-stable DMS packages rather than upgrading the whole system to unstable.

### Flake gotcha: untracked files are invisible

Nix flakes only see git-tracked files. A new `.nix` file that isn't `git add`-ed will produce errors like `path '…/source/modules/nixos/foo.nix' does not exist`. Use `git add -N <file>` to mark it intent-to-add (visible to nix, not staged for commit).

### GUI apps

GUI applications are installed exclusively via Flatpak (`modules/nixos/flatpak.nix`). CLI tools and system services come from nixpkgs in the relevant module. Adding a new GUI app means adding its Flatpak ID to `services.flatpak.packages`.

### Adding a new host

1. Create `hosts/<hostname>/` with `default.nix`, `home.nix`, `hardware-configuration.nix`, `disko.nix`
2. Add an entry to the `nixosConfigurations` attrset in `flake.nix` using `mkHost`

### Bootstrap / fresh install

Use `install.sh` (runs disko + nixos-install for `thinkpad`) or `bootstrap/configuration.nix` as a minimal live-USB config to get the system to first boot.
