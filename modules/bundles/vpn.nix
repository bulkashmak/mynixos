{ config, lib, pkgs, ... }:

let cfg = config.my.bundles.vpn;
in {
  options.my.bundles.vpn.enable = lib.mkEnableOption "VPN bundle (CLI clients + AmneziaVPN)";

  config = lib.mkIf cfg.enable {
    services.flatpak.packages = [
      "org.amnezia.AmneziaVPN"
    ];

    environment.systemPackages = with pkgs; [
      openvpn
      openconnect
      globalprotect-openconnect
    ];
  };
}
