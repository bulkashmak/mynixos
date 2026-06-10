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

      # Media
      "org.gnome.Showtime"
      "org.gnome.Decibels"
    ];
  };
}
