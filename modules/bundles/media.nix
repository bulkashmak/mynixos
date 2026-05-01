{ config, lib, pkgs, ... }:

let cfg = config.my.bundles.media;
in {
  options.my.bundles.media.enable = lib.mkEnableOption "media bundle (image/audio/video tools, OBS)";

  config = lib.mkIf cfg.enable {
    services.flatpak.packages = [
      "org.gimp.GIMP"
      "com.github.PintaProject.Pinta"
      "com.rawtherapee.RawTherapee"
      "com.obsproject.Studio"
      "org.videolan.VLC"
    ];

    # OBS virtual camera — the v4l2loopback module needs to live in the system,
    # flatpak'd OBS still uses the host kernel module.
    boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    boot.kernelModules = [ "v4l2loopback" ];
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Virtual Camera" exclusive_caps=1
    '';
  };
}
