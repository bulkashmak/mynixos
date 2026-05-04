{ config, lib, pkgs, ... }:

{
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
      # Kernels live on the XBOOTLDR partition (mounted at /boot) declared in
      # the host's disko.nix; the ESP at /efi just holds the bootloader binary.
      xbootldrMountPoint = "/boot";
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/efi";
    };
  };

  # zram-backed compressed swap. Sized at 50% of RAM (≈ 8 G with 16 G installed),
  # higher priority than the on-disk swap partition so the disk is only used
  # for hibernation and overflow.
  zramSwap = {
    enable = true;
    memoryPercent = 50;
    algorithm = "zstd";
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org"
      "https://niri.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  security.polkit.enable = true;
  security.rtkit.enable = true;

  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    stow
    wget
    curl
    unzip
    jq
    gcc
    gnumake
    wl-clipboard
    brightnessctl
    playerctl
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  system.stateVersion = "25.11";
}
