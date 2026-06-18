{ lib, config, ... }:

{
  options.my.laptop.enable = lib.mkEnableOption
    "laptop-only services (thermald, power-profiles-daemon, libinput touchpad)";

  config = lib.mkIf config.my.laptop.enable {
    services.thermald.enable = true;
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;

    services.libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        tapping = true;
      };
    };
  };
}
