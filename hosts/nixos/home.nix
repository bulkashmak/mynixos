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
    xfce.thunar
    firefox
    bitwarden
    telegram-desktop
    obsidian
    libreoffice-qt6-fresh
    godot
    globalprotect-openconnect
    vlc
    feh # image viewer
    rawtherapee
    pinta
    gimp
    vscode
    amnezia-vpn
    # Unfree
    google-chrome
    slack
    zoom-us
    jetbrains.idea-ultimate
    beekeeper-studio
    postman
    spotify
    discord
    code-cursor
    
    # Apps TUI
    neovim
    yazi
    fzf
    lazygit
    lazydocker
    btop
    fastfetch
    impala # wifi manager, need to disable other wifi services like wpa and NetworkManager and enable iwq for this to work
    bluetuith
    #wiremix # unstable branch

    # Apps CLI
    starship
    tmux
    dragon-drop
    lsd
    openconnect_openssl
    globalprotect-openconnect
    openvpn
    kafkactl
    unzip
    jq
    podman
    podman-tui
    podman-compose

    # Services
    postgresql

    # Languages
    go
    rustc
    cargo

    # LSPs and Formatters for Neovim
    vale
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
      alias forti="~/.scripts/openconnect-fortinet.sh"
      alias gp01="~/.scripts/openconnect-globalprotect-01.sh"
      alias blue="bluetuith"

      # Exports
      export PATH=$PATH:$HOME/go/bin
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
    HYPRSHOT_DIR = "/home/bulat/Pictures/Screenshots";
  };

  home = {
    pointerCursor = { 
      gtk.enable = true;
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 32;
    };
  };

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    settings = hyprlandConf;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark"; # "Material-black-colors" "Gruvbox-B"
      package = pkgs.materia-theme; # pkgs.material-black-colors pkgs.gruvbox-gtk-theme
    };
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
