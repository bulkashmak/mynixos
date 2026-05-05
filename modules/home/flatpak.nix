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
      "io.github.kolunmi.Bazaar"
      "io.github.flattool.Warehouse"
      "com.github.tchx84.Flatseal"

      # Web
      "app.zen_browser.zen"
      "de.haeckerfelix.Fragments"

      # Social
      "com.discordapp.Discord"
      "com.slack.Slack"

      # Productivity
      "com.bitwarden.desktop"
      "md.obsidian.Obsidian"
      "com.obsproject.Studio"

      # Media
      "org.gnome.Showtime"
      "org.gnome.Decibels"
    ];
  };
}
