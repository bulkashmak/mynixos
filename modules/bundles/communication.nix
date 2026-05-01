{ config, lib, ... }:

let cfg = config.my.bundles.communication;
in {
  options.my.bundles.communication.enable = lib.mkEnableOption "communication bundle (chat, video calls)";

  config = lib.mkIf cfg.enable {
    services.flatpak.packages = [
      "org.telegram.desktop"
      "com.slack.Slack"
      "us.zoom.Zoom"
      "com.discordapp.Discord"
    ];
  };
}
