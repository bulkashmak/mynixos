{
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
}
