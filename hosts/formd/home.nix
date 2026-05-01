{ config, lib, ... }:

{
  # Per-host niri output declarations.
  # Replace with real values from `niri msg outputs` after the first boot into niri.
  my.niri.outputs = ''
    // TODO: fill in actual desktop monitor mode/scale/position
    output "DP-1" {
        mode "2560x1440@144"
        scale 1
        position x=0 y=0
    }
  '';
}
