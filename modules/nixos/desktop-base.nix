{ pkgs, ... }:

{
  hardware.graphics.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    # niri implements screen capture via GNOME's Mutter ScreenCast interface,
    # so the ScreenCast/RemoteDesktop backends must route to gnome (gtk does
    # not implement them). Declared here so it lands in /etc and doesn't rely
    # on a hand-written ~/.config/xdg-desktop-portal file.
    config.common = {
      default = [ "gnome" "gtk" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
      "org.freedesktop.impl.portal.RemoteDesktop" = [ "gnome" ];
    };
  };

  services.gnome.gnome-keyring.enable = true;
  programs.dconf.enable = true;

  services.printing.enable = true;
}
