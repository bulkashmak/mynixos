# Placeholder — overwrite this file with the output of `nixos-generate-config --show-hardware-config`
# during the desktop NixOS install (or copy /etc/nixos/hardware-configuration.nix into here).
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # TODO: fill in real values for the desktop machine.
  boot.initrd.availableKernelModules = [ ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # fileSystems."/" = { device = "/dev/disk/by-uuid/..."; fsType = "ext4"; };
  # fileSystems."/boot" = { device = "/dev/disk/by-uuid/..."; fsType = "vfat"; options = [ "fmask=0022" "dmask=0022" ]; };
  # swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
