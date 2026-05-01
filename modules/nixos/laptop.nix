{ config, lib, ... }:

let cfg = config.my.laptop;
in {
  options.my.laptop.enable = lib.mkEnableOption "laptop power-management and touchpad bits";

  config = lib.mkIf cfg.enable {
    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 90;
      };
    };

    services.thermald.enable = true;

    services.libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        tapping = true;
      };
    };
  };
}
