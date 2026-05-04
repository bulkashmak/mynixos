{ pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.bash.enable = true;

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

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
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };
}
