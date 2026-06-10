{ lib, ... }:

let
  wallpaper = ../../static/wallpapers/starship.jpg;
in
{
  programs.noctalia-shell = {
    enable = true;

    settings = {
      wallpaper = {
        enabled = true;
      };

      colorSchemes = {
        darkMode = true;
        # Generate a Material palette from the current wallpaper.
        useWallpaperColors = true;
      };
    };
  };

  # Noctalia stores the active wallpaper in a writable cache
  # (~/.cache/noctalia/wallpapers.json), not in settings.json, so there is no
  # declarative settings key for it. Push our wallpaper via IPC once the shell
  # is up. The retry loop covers the gap before noctalia's IPC socket is ready;
  # the cache stays writable, so picking another wallpaper in the UI still works
  # until the next login.
  my.niri.extraConfig = ''
    spawn-at-startup "sh" "-c" "for i in $(seq 30); do noctalia-shell ipc call wallpaper set ${toString wallpaper} all && break; sleep 1; done"
  '';
}
