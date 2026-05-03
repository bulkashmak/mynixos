{
  description = "Bulat's NixOS flake — multi-host (thinkpad, desktop), niri + DankMaterialShell, declarative flatpaks";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

        formd = mkHost {
          hostname = "formd";
          username = "bulat";
        };
      };
    };
}
