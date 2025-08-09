{
  # Monitor
  monitor = [ "eDP-1,1920x1080@60,0x0,1" ];

  # Apps
  terminal = "kitty";
  fileManager = "dolphin";
  menu = "wofi --show drun";

  # Autostart
  exec-once = [
    "waybar"
  ];

  # Environment variables
  env = [
    "XCURSOR_SIZE,24"
    "HYPRCURSOR_SIZE,24"
  ];

  # Loog and feel
  general = {
    gaps_in = 3;
    gaps_out = 5;

    border_size = 2;

    col = {
      active_border = "rgba(ffffffff)";
      inactive_border = "rgba(595959aa";
    };

    resize_on_border = false;
    allow_tearing = false;
    layout = "dwindle";
  };

  decoration = {
    rounding = 10;
    rounding_power = 2;

    active_opacity = 1.0;
    inactive_opacity = 1.0;

    shadow = {
      enabled = true;
      range = 4;
      render_power = 3;
      color = "rgba(1a1a1aee)";
    };

    blur = {
      enabled = true;
      size = 3;
      passes = 1;
      vibrancy = 1.1696;
    };
  };

  # TODO animations

  dwindle = {
    pseudotile = true;
    preserve_split = true;
  };

  # Algorithm
  master = {
    new_status = "master";
  };

  # Misc
  misc = {
    force_default_wallpaper = 0;
    disable_hyprland_logo = true;
  };

  # Input
  input = {
    kb_layout = "us";
    
    follow_mouse = 1;

    sensitivity = 0;

    touchpad = {
      natural_scroll = false;
    };
  };

  # Gestures
  gestures = {
    workspace_swipe = false;
  };

  # Key bindings
  mainMod = "SUPER";

  bind = [
    "${mainMod}, E, exec, ${terminal}"
    "${mainMod}, F, exec, ${fileManager}"
    "${mainMod}, SPACE, exec, ${menu}"

    "${mainMod}, Q, killactive,"
    "${mainMod}, V, togglefloating,"
  ];

  bindm = [
    "${mainMod}, mouse:272, movewindow"
    "${mainMod}, mouse:273, resizewindow"
  ];
}
