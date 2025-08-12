{
  ################
  ### MONITORS ###
  ################

  monitor = [ "eDP-1,1920x1200@60,0x0,1" ];

  xwayland = {
    enabled = true;
    force_zero_scaling = true;
  };


  ###################
  ### APPLICATIONS ##
  ###################

  # terminal = "kitty";
  # fileManager = "dolphin";
  # menu = "wofi --show drun";


  #################
  ### AUTOSTART ###
  #################

  exec-once = [
    "waybar"
    "hyprpaper"
    "hypridle"
  ];

 
  #############################
  ### ENVIRONMENT VARIABLES ###
  #############################

  env = [
    "XCURSOR_THEME,Capitaine-cursor"
    "XCURSOR_SIZE,24"
    "HYPRCURSOR_SIZE,24"
  ];


  ###################
  ### PERMISSIONS ###
  ###################


  #####################
  ### LOOK AND FEEL ###
  #####################

  general = {
    gaps_in = 3;
    gaps_out = 9;

    border_size = 2;

    "col.active_border" = "rgba(981e32ff)";
    "col.inactive_border" = "rgba(595959aa)";

    resize_on_border = false;
    allow_tearing = false;
    layout = "dwindle";
  };

  decoration = {
    rounding = 5;
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

  animations = {
    enabled = "yes, please :)";

    # Default animations, see https://wiki.hypr.land/Configuring/Animations/ for more

    bezier = [
      "easeOutQuint,0.23,1,0.32,1"
      "easeInOutCubic,0.65,0.05,0.36,1"
      "linear,0,0,1,1"
      "almostLinear,0.5,0.5,0.75,1.0"
      "quick,0.15,0,0.1,1"
    ];

    animation = [
      "global, 1, 10, default"
      "border, 1, 5.39, easeOutQuint"
      "windows, 1, 4.79, easeOutQuint"
      "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
      "windowsOut, 1, 1.49, linear, popin 87%"
      "fadeIn, 1, 1.73, almostLinear"
      "fadeOut, 1, 1.46, almostLinear"
      "fade, 1, 3.03, quick"
      "layers, 1, 3.81, easeOutQuint"
      "layersIn, 1, 4, easeOutQuint, fade"
      "layersOut, 1, 1.5, linear, fade"
      "fadeLayersIn, 1, 1.79, almostLinear"
      "fadeLayersOut, 1, 1.39, almostLinear"
      #"workspaces, 1, 1.94, almostLinear, fade"
      #"workspacesIn, 1, 1.21, almostLinear, fade"
      #"workspacesOut, 1, 1.94, almostLinear, fade"
      "workspaces, 1, 3, easeOutQuint, slide"
      "workspacesIn, 1, 3, easeOutQuint, slide"
      "workspacesOut, 1, 3, easeOutQuint, slide"

      "specialWorkspace, 1, 2, default, slidevert"
    ];
  };

  dwindle = {
    pseudotile = true;
    preserve_split = true;
  };

  master = {
    new_status = "master";
  };

  misc = {
    force_default_wallpaper = 0;
    disable_hyprland_logo = true;
  };


  #############
  ### INPUT ###
  #############

  input = {
    kb_layout = "us,ru";
    kb_options = "grp:alt_shift_toggle";
    
    follow_mouse = 1;

    sensitivity = 0;

    touchpad = {
      natural_scroll = true;
      scroll_factor = 0.3;
    };
  };

  gestures = {
    workspace_swipe = false;
  };

  device = {
    name = "epic-mouse-v1";
    sensitivity = -0.5;
  };


  ###################
  ### KEYBINDINGS ###
  ###################

  # mainMod = "SUPER";

  bind = [
    # Apps
    "SUPER, E, exec, ghostty"
    "SUPER, F, exec, dolphin"
    "SUPER, SPACE, exec, GTK_ICON_THEME=WhiteSur wofi --show drun --allow-images"

    "$SUPER_SHIFT, L, exec, hyprlock"

    ", PRINT, exec, hyprshot -m window" # window
    "SUPER, PRINT, exec, hyprshot -m output" # screen
    "$SUPER_SHIFT, PRINT, exec, hyprshot -m region" # selection

    "SUPER, Q, killactive,"
    "SUPER, V, togglefloating,"
    "SUPER, P, pseudo,"
    "SUPER, O, togglesplit,"
    "$SUPER_SHIFT, M, exit,"

    "CTRL ALT SUPER, comma, movecurrentworkspacetomonitor, l"
    "CTRL ALT SUPER, period, movecurrentworkspacetomonitor, r"

    # Move focus
    "SUPER, h, movefocus, l"
    "SUPER, l, movefocus, r"
    "SUPER, k, movefocus, u"
    "SUPER, j, movefocus, d"
    
    # Switch workspaces
    "SUPER, 1, workspace, 1"
    "SUPER, 2, workspace, 2"
    "SUPER, 3, workspace, 3"
    "SUPER, 4, workspace, 4"
    "SUPER, 5, workspace, 5"
    "SUPER, 6, workspace, 6"
    "SUPER, 7, workspace, 7"
    "SUPER, 8, workspace, 8"
    "SUPER, 9, workspace, 9"
    "SUPER, 0, workspace, 10"

    # Move window to workspace
    "SUPER SHIFT, 1, movetoworkspace, 1"
    "SUPER SHIFT, 2, movetoworkspace, 2"
    "SUPER SHIFT, 3, movetoworkspace, 3"
    "SUPER SHIFT, 4, movetoworkspace, 4"
    "SUPER SHIFT, 5, movetoworkspace, 5"
    "SUPER SHIFT, 6, movetoworkspace, 6"
    "SUPER SHIFT, 8, movetoworkspace, 8"
    "SUPER SHIFT, 9, movetoworkspace, 9"
    "SUPER SHIFT, 0, movetoworkspace, 10"

    # Special workspace
    "SUPER, S, togglespecialworkspace, magic"
    "super SHIFT, S, movetoworkspace, special:magic"

    # Scroll through workspaces
    "SUPER, mouse_down, workspace, e+1"
    "SUPER, mouse_up, workspace, e-1"
  ];

  bindm = [
    # Move windows with SUPER + LMB and dragging
    "SUPER, mouse:272, movewindow"
    # Resize windows with SUPER + RMB and dragging
    "SUPER, mouse:273, resizewindow"
  ];

  bindel = [
    # Keyboard multimedia keys for volume
    ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
    ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

    # Keyboard multimedia keys for display brightness. Requires brightnessctl
    ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
    ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"

    # Keyboard multimedia keys for player. Requires playerctl
    ", XF86AudioNext, exec, playerctl next"
    ", XF86AudioPause, exec, playerctl play-pause"
    ", XF86AudioPlay, exec, playerctl play-pause"
    ", XF86AudioPrev, exec, playerctl previous"
  ];


  ##############################
  ### WINDOWS AND WORKSPACES ###
  ############################## 

  windowrule = [
    # Ignore maximize requests from apps
    "suppressevent maximize, class:.*"

    # Fix some dragging issues with XWayland
    "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
  ];
}
