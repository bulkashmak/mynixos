{ inputs, pkgs, ... }:

{
  # niri-flake overlay exposes `pkgs.niri-stable` and `pkgs.niri-unstable`.
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  programs.niri.enable = true;
  # niri-flake's `niri-stable` is pinned to v25.08, which doesn't support the `include`
  # KDL directive (added in v25.11). DMS injects `include` lines into our config, so
  # validation fails. Use the nixpkgs niri (25.11) which supports `include` and is also
  # already on cache.nixos.org.
  programs.niri.package = pkgs.niri;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-user-session --asterisks --cmd niri-session";
        user = "greeter";
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/cache/tuigreet 0755 greeter greeter -"
  ];
}
