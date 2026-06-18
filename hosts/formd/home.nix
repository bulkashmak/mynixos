{ config, lib, ... }:

{
  my.noctalia.wallpaper = ../../static/wallpapers/hailmary-red.jpg;

  # Per-host niri output declarations. Captured from `niri msg outputs` on
  # the live formd setup: Gigabyte M27Q X (DP-2, 1440p240) as primary, with
  # a Stargate SIDETRAK portable (HDMI-A-1, 1080p60) docked to its right.
  my.niri.outputs = ''
    output "GIGA-BYTE TECHNOLOGY CO., LTD. M27Q X 23500B005738" {
        mode "2560x1440@239.998"
        scale 1
        position x=0 y=0
    }

    output "Stargate Technology SIDETRAK 00000" {
        mode "1920x1080@60.000"
        scale 1
        position x=2560 y=0
    }
  '';
}
