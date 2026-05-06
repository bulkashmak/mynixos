{ pkgs, ... }:

{
  home.packages = [
    pkgs.codex
    pkgs.fastfetch
    pkgs.lazygit
    pkgs.lazydocker
  ];
}
