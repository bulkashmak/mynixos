{
  # Flatpak runtime + dbus service.
  # Package management is done per-user in modules/home/flatpak.nix.
  services.flatpak.enable = true;
}
