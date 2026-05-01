{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  my.bundles = {
    dev = {
      enable = true;
      postgresql.enable = true;
    };
    media.enable = true;
    communication.enable = true;
    productivity.enable = true;
    browsers.enable = true;
    vpn.enable = true;
    gaming.enable = true;
  };
}
