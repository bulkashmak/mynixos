{ lib, config, ... }:

lib.mkIf config.my.dev.enable {
  # Podman provides the `docker` CLI via dockerCompat — no second engine,
  # no socket conflict. If you ever need the upstream Docker daemon
  # instead, swap this for `virtualisation.docker.enable = true`.
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}
