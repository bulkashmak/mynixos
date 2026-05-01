{ config, lib, pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # CLI tools
    yazi
    fzf
    lazygit
    btop
    fastfetch
    impala
    tmux
    lsd
    starship
    dragon-drop
    ripgrep
    fd
  ];

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      eval "$(starship init bash)"

      alias l="lsd -la"
      alias ll="lsd -l"
      alias ls="lsd"
      alias blue="bluetuith"

      export PATH=$PATH:$HOME/go/bin:$HOME/.cargo/bin
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "Bulat";
    userEmail = "mbmhd2015@gmail.com";
    extraConfig = {
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
    EDITOR = "nvim";
    HYPRSHOT_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
  };
}
