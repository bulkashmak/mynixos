{ config, lib, pkgs, inputs, ... }:

let
  # The DMS settings.json, ported from the existing ~/.config/DankMaterialShell/settings.json.
  # When DMS rewrites this file at runtime to reflect UI toggles, those changes will be wiped on the
  # next home-manager activation. Declare the desired state here.
  settings = import ./settings.nix;
  pluginSettings = import ./plugin-settings.nix;
in
{
  # Note the kebab-case attribute path — the upstream module uses `programs.dank-material-shell`,
  # not `programs.dankMaterialShell`.
  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
    # dgop is not in nixpkgs and DMS does not ship it; pull it from its own flake.
    dgop.package = inputs.dgop.packages.${pkgs.system}.dgop;
  };

  # The DMS daemon writes its matugen-generated KDL fragments into ~/.config/niri/dms/ at runtime
  # regardless of any home-manager niri integration; our niri config (modules/home/niri/default.nix)
  # `include`s them. We deliberately do NOT import inputs.dms.homeModules.niri because we drive
  # spawn-at-startup, keybinds and the main niri config ourselves.

  # Drop the DMS settings.json and plugin_settings.json declaratively. Any DMS UI changes are NOT
  # persisted across rebuilds — edit settings.nix to change.
  home.file.".config/DankMaterialShell/settings.json".source =
    (pkgs.formats.json { }).generate "dms-settings.json" settings;

  home.file.".config/DankMaterialShell/plugin_settings.json".source =
    (pkgs.formats.json { }).generate "dms-plugin-settings.json" pluginSettings;
}
