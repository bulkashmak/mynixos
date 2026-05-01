{ config, lib, ... }:

let cfg = config.my.bundles.gaming;
in {
  options.my.bundles.gaming.enable = lib.mkEnableOption "gaming bundle (Steam, Godot)";

  config = lib.mkIf cfg.enable {
    services.flatpak.packages = [
      "com.valvesoftware.Steam"
      "org.godotengine.Godot"
    ];

    hardware.steam-hardware.enable = true;
    programs.gamemode.enable = true;
  };
}
