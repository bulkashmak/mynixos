{ ... }:
{
  services.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
      # Qt's gtk2 platform theme has no Wayland backend and crashes the server
      # with "cannot open display". Run vicinae without a platform theme.
      environment.QT_QPA_PLATFORMTHEME = "";
    };
  };
}
