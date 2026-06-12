{ inputs, system }:

{ hostname, username }:

inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs hostname username; };
  modules = [
    # Shared module roots
    ../modules/nixos

    # Third-party NixOS modules
    inputs.home-manager.nixosModules.home-manager
    inputs.niri.nixosModules.niri
    inputs.disko.nixosModules.disko

    # Host-specific
    ../hosts/${hostname}

    # Wire home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "hm-bak";
        extraSpecialArgs = { inherit inputs hostname username; };
        sharedModules = [
          inputs.nix-flatpak.homeManagerModules.nix-flatpak
          inputs.noctalia.homeModules.default
        ];
        users.${username} = {
          imports = [
            ../modules/home
            ../hosts/${hostname}/home.nix
          ];
        };
      };
    }
  ];
}
