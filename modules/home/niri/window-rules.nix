{ lib, ... }:

{
  options.my.niri._kdl.windowRules = lib.mkOption {
    type = lib.types.lines;
    internal = true;
  };

  config.my.niri._kdl.windowRules = ''
    // Global corner radius
    window-rule {
        geometry-corner-radius 12
        clip-to-geometry true
    }

    // Don't fill transparent windows with focus-ring/border color
    window-rule {
        draw-border-with-background false
    }

    // Zoom: float everything by default (catches all the small popups),
    // then un-float only the main meeting/settings windows below.
    window-rule {
        match app-id="zoom"
        open-floating true
    }

    window-rule {
        match app-id="zoom" title="^Zoom Meeting$"
        match app-id="zoom" title="Settings"
        match app-id="zoom" title="Zoom - Free Account"
        match app-id="zoom" title="Zoom Workplace"

        open-floating false
    }

    // Float Firefox/Zen Picture-in-Picture
    window-rule {
        match app-id=r#"firefox$"# title="^Picture-in-Picture$"
        match app-id=r#"zen$"# title="^Picture-in-Picture$"
        open-floating true
    }

    // Open Zen browser and Slack maximized (full column width)
    window-rule {
        match app-id=r#"zen$"#
        match app-id=r#"^com\.slack\.Slack$"#
        open-maximized true
    }

    // Workaround WezTerm's initial-configure bug
    window-rule {
        match app-id=r#"^org\.wezfurlong\.wezterm$"#
        default-column-width {}
    }
  '';
}
