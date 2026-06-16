{ lib, config, pkgs, ... }:

lib.mkIf config.my.dev.enable {
  environment.systemPackages = with pkgs; [
    go
    jdk
    nodejs_24
  ];
}
