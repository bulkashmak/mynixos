{ inputs, pkgs, ... }:

{
  # niri-flake overlay exposes `pkgs.niri-stable` and `pkgs.niri-unstable`.
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  programs.niri.enable = true;

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
