{ lib, ... }:

{
  options.my.niri._kdl.windowRules = lib.mkOption {
    type = lib.types.lines;
    internal = true;
  };

  config.my.niri._kdl.windowRules = ''
    // Don't fill transparent windows with focus-ring/border color
    window-rule {
        draw-border-with-background false
    }

    // Zoom: float small popup windows, keep main meeting unfloated
    window-rule {
        match app-id="zoom" title="^zoom$"
        match app-id="zoom" title="as_toolbar"
        match app-id="zoom" title="as_taskbar"
        match app-id="zoom" title="^Zoom$"
        match app-id="zoom" title="meeting_controls"
        match app-id="zoom" title="notification"
        match app-id="zoom" title="^pop_up_wnd$"

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

    // Workaround WezTerm's initial-configure bug
    window-rule {
        match app-id=r#"^org\.wezfurlong\.wezterm$"#
        default-column-width {}
    }
  '';
}
