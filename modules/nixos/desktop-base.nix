{ pkgs, ... }:

{
  hardware.graphics.enable = true;

  # Zoom is a native package rather than a Flatpak: the Flatpak sandbox's
  # portal/Wayland screen-share path is unreliable under niri.
  environment.systemPackages = [ pkgs.zoom-us ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config.common.default = [ "gnome" "gtk" ];
  };

  services.gnome.gnome-keyring.enable = true;
  programs.dconf.enable = true;

  services.printing.enable = true;
}
