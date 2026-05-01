{ config, lib, ... }:

{
  # Per-host niri output declarations.
  # Run `niri msg outputs` once you're inside niri to refine these.
  my.niri.outputs = ''
    output "eDP-1" {
        mode "1920x1200@60.026"
        scale 1
        position x=0 y=0
    }
  '';
}
