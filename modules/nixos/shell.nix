{ pkgs, inputs, ... }:

let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    config.allowUnfree = true;
  };
in
{
  programs.dank-material-shell = {
    enable = true;
    dgop.package = pkgs-unstable.dgop;
  };
}
