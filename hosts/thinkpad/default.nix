{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  my.laptop.enable = true;

  my.bundles = {
    dev = {
      enable = true;
      postgresql.enable = false;
    };
    media.enable = true;
    communication.enable = true;
    productivity.enable = true;
    browsers.enable = true;
    vpn.enable = true;
    gaming.enable = false;
  };
}
