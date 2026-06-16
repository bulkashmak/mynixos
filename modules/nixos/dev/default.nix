{ lib, ... }:

{
  imports = [
    ./containers.nix
    ./runtimes.nix
  ];

  options.my.dev.enable = lib.mkEnableOption
    "developer bundle (podman+docker CLI, Go, JDK, Node.js)";
}
