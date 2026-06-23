{ pkgs, ... }:

{
  hardware.graphics.enable = true;

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
