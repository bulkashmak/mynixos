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
    google-chrome # unfree
    slack #unfree

    # Apps CLI
    neovim
    starship
    yazi
    dragon-drop
    lazygit

    # Services

    # LSPs and Formatters for Neovim
    ## Golang
    gopls
    gofumpt
    golangci-lint
    ## Lua
    luajitPackages.lua-lsp
    stylua

    nerd-fonts.jetbrains-mono
    whitesur-icon-theme
    capitaine-cursors
  ];
  # Allow unfree packages, such as google-chrome
  nixpkgs.config.allowUnfree = true;

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
    #XCURSOR_THEME = "Capitaine Cursors";
    #XCURSOR_SIZE = "24";
  };

  #home.pointerCursor = { 
  #  name = "Capitaine Cursors";
  #  package = pkgs.capitaine-cursors;
  #  size = 24;
  #};

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    settings = hyprlandConf;
  };

  gtk = {
    enable = true;
    #cursorTheme = {
    #  name = "Capitaine Cursors";
    #  package = pkgs.capitaine-cursors;
    #};
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
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
