{ lib, ... }:

{
  imports = [
    ./steam.nix
    ./hardware.nix
  ];

  options.my.gaming.enable = lib.mkEnableOption
    "gaming bundle (Steam, Gamescope, GameMode, MangoHud, LACT, CoolerControl)";
}
