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
