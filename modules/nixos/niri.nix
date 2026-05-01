{ inputs, pkgs, ... }:

{
  # Apply niri-flake overlay so `pkgs.niri-stable` and `pkgs.niri-unstable` are available
  # (the niri-flake nixosModule itself defaults to a sensible choice; we just want the
  # overlay around in case other modules want to pin a specific version).
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
