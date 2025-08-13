{ config, pkgs, inputs, ... }:

let
  hyprlandConf = import ./../../modules/hyprland/hyprland.nix;
in {
  imports = [
      inputs.zen-browser.homeModules.beta
  ];

  home.username = "bulat";
  home.homeDirectory = "/home/bulat";

  home.packages = with pkgs; [
    # Apps GUI
    ghostty
    nautilus
    firefox
    bitwarden
    godot
    # Unfree
    google-chrome
    slack
    jetbrains.idea-ultimate
    postman
    spotify

    # Apps CLI
    neovim
    starship
    yazi
    dragon-drop
    lazygit
    lsd
    openconnect_openssl
    unzip

    # Services

    # Languages
    go
    rustc
    cargo

    # LSPs and Formatters for Neovim
    ## Golang
    gopls
    gofumpt
    golangci-lint
    ## Lua
    luajitPackages.lua-lsp
    stylua
    nerd-fonts.jetbrains-mono
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.1.5"
  ];
  # Allow unfree packages, such as google-chrome
  nixpkgs.config.allowUnfree = true;

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      # Starship init
      eval "$(starship init bash)"

      # Aliases
      alias l="lsd -la"
      alias ll="lsd -l"
      alias ls="lsd"
    '';
  };
  programs.git = {
    enable = true;
    userName = "Bulat";
    userEmail = "mbmhd2015@gmail.com";
    extraConfig = {
        init.defaultBranch = "main";
    };
  };
  programs.zen-browser.enable = true;

  home.sessionVariables = {
    HYPRSHOT_DIR = "/home/bulat/pictures/screenshots";
  };

  home = {
    pointerCursor = { 
      gtk.enable = true;
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 24;
    };
  };

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    settings = hyprlandConf;
  };

  gtk = {
    enable = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
