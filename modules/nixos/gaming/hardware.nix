{ lib, config, pkgs, ... }:

lib.mkIf config.my.gaming.enable {
  # Unlock the full AMDGPU power-management feature mask so LACT can expose
  # voltage/clock/fan controls. Safe on RDNA; ignored on non-AMD hardware.
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];

  # LACT daemon: AMD/NVIDIA GPU control (fan curves, clocks, undervolt).
  # nixpkgs does not ship a top-level module yet, so wire the daemon directly.
  environment.systemPackages = [ pkgs.lact ];
  systemd.services.lactd = {
    description = "AMDGPU Control Daemon (LACT)";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
      Restart = "on-failure";
    };
  };

  # CoolerControl: unified fan/pump/cooling control across motherboard + AIO.
  programs.coolercontrol.enable = true;
}
