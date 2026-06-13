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
        # Use a fixed predefined scheme rather than deriving colors from the
        # wallpaper.
        useWallpaperColors = false;
        # "Oxide" is a community scheme; Noctalia only finds it once its JSON is
        # present under ~/.config/noctalia/colorschemes (see xdg.configFile below).
        predefinedScheme = "Oxide";
      };

      # Drop shadows under bars and panels. There is no per-bar shadow toggle in
      # Noctalia (the old `bar.showShadow` key here was silently ignored — it
      # isn't part of the schema); this global flag is what actually renders the
      # shadow beneath the top bar. Disabling it also removes panel shadows.
      general.enableShadows = false;

      bar = {
        # Bar height is driven by the density preset (no raw pixel option):
        # mini 21 · compact 25 · default 31 · comfortable 37 · spacious 47.
        density = "comfortable";

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
          # tray -> keyboard layout -> battery -> brightness -> volume -> control center -> notifications
          right = [
            { id = "Tray"; }
            # Keyboard layout always rendered (forceOpen) and shown as text only
            # (showIcon = false drops the leading keyboard glyph).
            {
              id = "KeyboardLayout";
              displayMode = "forceOpen";
              showIcon = false;
            }
            # `graphic` keeps the default circular battery but renders the
            # percentage text inside it (default `graphic-clean` hides it).
            {
              id = "Battery";
              displayMode = "graphic";
            }
            # alwaysShow keeps the value label visible instead of only on hover.
            {
              id = "Brightness";
              displayMode = "alwaysShow";
            }
            {
              id = "Volume";
              displayMode = "alwaysShow";
            }
            { id = "ControlCenter"; }
            { id = "NotificationHistory"; }
          ];
        };
      };
    };
  };

  # Noctalia scans ~/.config/noctalia/colorschemes for "downloaded" community
  # schemes alongside its preinstalled ones. Vendor the Oxide scheme there so the
  # `predefinedScheme = "Oxide"` setting above resolves without a manual download.
  # The scan uses `find -L`, so a symlink into the nix store is picked up fine.
  xdg.configFile."noctalia/colorschemes/Oxide/Oxide.json".source =
    ../../static/noctalia/colorschemes/Oxide.json;

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
