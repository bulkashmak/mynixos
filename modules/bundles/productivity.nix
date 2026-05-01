{ config, lib, ... }:

let cfg = config.my.bundles.productivity;
in {
  options.my.bundles.productivity.enable = lib.mkEnableOption "productivity bundle (notes, office, password manager)";

  config = lib.mkIf cfg.enable {
    services.flatpak.packages = [
      "md.obsidian.Obsidian"
      "org.libreoffice.LibreOffice"
      "com.bitwarden.desktop"
    ];
  };
}
