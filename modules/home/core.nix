{ pkgs, inputs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "Bulat Maskurov";
      user.email = "mbmhd2015@gmail.com";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 32;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
    # Without an explicit icon theme, GTK falls back to hicolor (the ugly
    # placeholder set). Papirus-Dark gives Nautilus a full icon set.
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    # Modern Nautilus is GTK4/libadwaita and ignores the GTK theme above; it
    # only follows the dark-mode preference. Set it for GTK3 and GTK4 so the
    # whole stack renders dark to match the Noctalia (Oxide) dark scheme.
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  # libadwaita / GNOME apps read the dark preference from this dconf key rather
  # than the GTK settings above.
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  home.sessionVariables = {
    EDITOR = "vim";
    DOCKER_HOST = "unix:///run/podman/podman.sock";
  };

  home.packages = [
    inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
