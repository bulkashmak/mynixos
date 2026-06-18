{ lib, osConfig, ... }:

{
  services.flatpak = {
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
    uninstallUnmanaged = true;
    remotes = [
      {
        name = "flathub";
        location = "https://flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      # Flatpak Ecosystem
      "io.github.flattool.Warehouse"
      "com.github.tchx84.Flatseal"

      # Web
      "app.zen_browser.zen"
      "us.zoom.Zoom"
      "de.haeckerfelix.Fragments"

      # Social
      "org.telegram.desktop"
      "com.slack.Slack"
      "com.discordapp.Discord"

      # Productivity
      "com.bitwarden.desktop"
      "md.obsidian.Obsidian"
      "com.obsproject.Studio"
      "org.localsend.localsend_app"

      # Editors / Dev
      "dev.zed.Zed"
      "com.visualstudio.code"
      "io.beekeeperstudio.Studio"
      "com.github.marhkb.Pods"

      # Media
      "org.gnome.Showtime"
      "org.gnome.Decibels"
      "org.videolan.vlc"
      "com.github.neithern.g4music"
      "com.rafaelmardojai.Blanket"
      "org.gnome.gitlab.YaLTeR.VideoTrimmer"

      # Graphics / Photo
      "org.gimp.GIMP"
      "com.github.PintaProject.Pinta"
      "com.rawtherapee.RawTherapee"
      "com.github.huluti.Curtail"

      # Audio
      "com.github.Flacon"

      # Utilities
      "org.qbittorrent.qBittorrent"
      "com.usebottles.bottles"
    ] ++ lib.optionals (osConfig.my.gaming.enable or false) [
      # Gaming launchers — installed only when the gaming bundle is on
      "com.heroicgameslauncher.hgl"
      "net.lutris.Lutris"
    ];
  };
}
