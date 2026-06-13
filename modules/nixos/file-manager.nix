{ pkgs, ... }:

# Thunar (XFCE) as the GUI file manager. Unlike libadwaita Nautilus, Thunar is
# GTK3 and honors the home-manager gtk.theme / gtk.iconTheme settings, so it
# picks up Materia-dark + Papirus-Dark and matches the rest of the desktop.
#
# This is a deliberate exception to the Flatpak-only GUI policy: a file manager
# needs native gvfs/tumbler integration for mounts, trash, and thumbnails, which
# Flatpak sandboxing breaks.
{
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman # removable-media management
      thunar-archive-plugin # extract/create archives from the context menu
    ];
  };

  # Trash, remote/removable mounts (MTP, smb, sftp), and the "Network" view.
  services.gvfs.enable = true;
  # Thumbnail generation for images, PDFs, etc.
  services.tumbler.enable = true;
}
