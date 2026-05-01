{ config, lib, ... }:

let cfg = config.my.bundles.browsers;
in {
  options.my.bundles.browsers.enable = lib.mkEnableOption "browsers bundle (Firefox, Chrome, Zen)";

  config = lib.mkIf cfg.enable {
    services.flatpak.packages = [
      "org.mozilla.firefox"
      "com.google.Chrome"
      "app.zen_browser.zen"
    ];
  };
}
