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
        #default.path = "../../static/wallpapers/starship.jpg"
      };

      colorSchemes = {
        darkMode = true;
        # Generate a Material palette from the current wallpaper.
        #useWallpaperColors = true;
      };

      bar = {
        # Only `left` and `right` are overridden; `center` keeps its default
        # (the Workspace widget). Noctalia deep-merges declared settings onto
        # its defaults, so omitted keys fall back to the shipped values.
        widgets = {
          # Default left set minus ActiveWindow (current-window widget removed).
          left = [
            { id = "Launcher"; }
            { id = "Clock"; }
            { id = "SystemMonitor"; }
            { id = "MediaMini"; }
          ];
          # tray -> battery -> brightness -> volume -> control center -> notifications
          right = [
            { id = "Tray"; }
            # `graphic` keeps the default circular battery but renders the
            # percentage text inside it (default `graphic-clean` hides it).
            {
              id = "Battery";
              displayMode = "graphic";
            }
            { id = "Brightness"; }
            { id = "Volume"; }
            { id = "ControlCenter"; }
            { id = "NotificationHistory"; }
          ];
        };
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
