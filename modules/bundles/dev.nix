{ config, lib, pkgs, ... }:

let cfg = config.my.bundles.dev;
in {
  options.my.bundles.dev = {
    enable = lib.mkEnableOption "developer tooling bundle (IDEs, languages, container runtime)";
    postgresql.enable = lib.mkEnableOption "local PostgreSQL service";
  };

  config = lib.mkIf cfg.enable {
    services.flatpak.packages = [
      "com.jetbrains.IntelliJ-IDEA-Ultimate"
      "com.getpostman.Postman"
      "io.beekeeperstudio.Studio"
      "com.visualstudio.code"
    ];

    environment.systemPackages = with pkgs; [
      # Languages / runtimes
      go
      rustc
      cargo
      python3
      nodejs

      # LSPs / formatters / linters
      gopls
      gofumpt
      golangci-lint
      lua-language-server
      stylua
      vale
      nil
      nixpkgs-fmt

      # CLI dev tools
      neovim
      lazygit
      lazydocker
      jq
      kafkactl
      podman-compose
      podman-tui
    ];

    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    services.postgresql = lib.mkIf cfg.postgresql.enable {
      enable = true;
      package = pkgs.postgresql_16;
    };
  };
}
