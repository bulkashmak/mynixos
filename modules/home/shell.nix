{ pkgs, lib, config, inputs, ... }:

let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    config.allowUnfree = true;
  };

  wallpaper = ../../static/wallpapers/starship.jpg;

  setWallpaper = pkgs.writeShellScript "dms-set-wallpaper" ''
    dms=${lib.getExe config.programs.dank-material-shell.package}
    for _ in $(seq 1 30); do
      if "$dms" ipc call wallpaper set ${wallpaper}; then
        exit 0
      fi
      sleep 1
    done
    exit 1
  '';
in
{
  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
    dgop.package = pkgs-unstable.dgop;

    plugins = {
      dankPomodoroTimer.enable = true;
      dankBatteryAlerts.enable = true;
      flatpakUpdates.enable = true;
      usbManager.enable = true;
    };

    session = {
      showThirdPartyPlugins = true;
    };

    settings = {
      currentThemeName = "orange";
      currentThemeCategory = "generic";

      showWorkspaceIndex = true;

      lockBeforeSuspend = true;
      acProfileName = "2";
      acLockTimeout = 600;
      acMonitorTimeout = 900;
      acSuspendTimeout = 1800;
      batteryProfileName = "1";
      batteryLockTimeout = 300;
      batteryMonitorTimeout = 600;
      batterySuspendTimeout = 900;

      barConfigs = [{
        id = "default";
        name = "Main Bar";
        enabled = true;
        position = 0;
        screenPreferences = [ "all" ];
        showOnLastDisplay = true;
        leftWidgets = [
          "launcherButton"
          "workspaceSwitcher"
          "music"
        ];
        centerWidgets = [
          "cpuUsage"
          { id = "memUsage"; enabled = true; showSwap = true; }
          "clock"
          "dankPomodoroTimer"
          "weather"
        ];
        rightWidgets = [
          "systemTray"
          "clipboard"
          "flatpakUpdates"
          "usbManager"
          { id = "keyboard_layout_name"; enabled = true; keyboardLayoutNameCompactMode = true; }
          "battery"
          "controlCenterButton"
          "notificationButton"
        ];
        spacing = 4;
        innerPadding = 4;
        bottomGap = 0;
        transparency = 1.0;
        widgetTransparency = 1.0;
        squareCorners = false;
        noBackground = false;
        maximizeWidgetIcons = false;
        maximizeWidgetText = false;
        removeWidgetPadding = false;
        widgetPadding = 8;
        gothCornersEnabled = false;
        gothCornerRadiusOverride = false;
        gothCornerRadiusValue = 12;
        borderEnabled = false;
        borderColor = "surfaceText";
        borderOpacity = 1.0;
        borderThickness = 1;
        widgetOutlineEnabled = false;
        widgetOutlineColor = "primary";
        widgetOutlineOpacity = 1.0;
        widgetOutlineThickness = 1;
        fontScale = 1.0;
        iconScale = 1.0;
        autoHide = false;
        autoHideDelay = 250;
        showOnWindowsOpen = false;
        openOnOverview = false;
        visible = true;
        popupGapsAuto = true;
        popupGapsManual = 4;
        maximizeDetection = true;
        scrollEnabled = true;
        scrollXBehavior = "column";
        scrollYBehavior = "workspace";
        shadowIntensity = 0;
        shadowOpacity = 60;
        shadowColorMode = "text";
        shadowCustomColor = "#000000";
        clickThrough = false;
      }];
    };
  };

  systemd.user.services.dms-wallpaper = {
    Unit = {
      Description = "Set DankMaterialShell wallpaper";
      After = [ "dms.service" ];
      Requires = [ "dms.service" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${setWallpaper}";
      RemainAfterExit = true;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
