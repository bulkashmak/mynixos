{ inputs, system }:

{ hostname, username }:

inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs hostname username; };
  modules = [
    # Shared module roots
    ../modules/nixos
    ../modules/bundles

    # Third-party NixOS modules
    inputs.home-manager.nixosModules.home-manager
    inputs.niri.nixosModules.niri
    inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.disko.nixosModules.disko

    # Host-specific
    ../hosts/${hostname}

    # Wire home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs hostname username; };
        users.${username} = {
          imports = [
            ../modules/home
            ../hosts/${hostname}/home.nix
            inputs.dms.homeModules.dank-material-shell
          ];
        };
      };
    }
  ];
}
