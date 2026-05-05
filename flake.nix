{
  description = "Bulat's NixOS flake — thinkpad, niri, declarative flatpaks";

  inputs = {
    # Nix Ecosystem
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Desktop Environment
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flatpak
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    # Shell
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Other
    claude-code.url = "github:sadjow/claude-code-nix";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      mkHost = import ./lib/mkHost.nix { inherit inputs system; };
    in
    {
      nixosConfigurations = {
        thinkpad = mkHost {
          hostname = "thinkpad";
          username = "bulat";
        };
      };
    };
}
