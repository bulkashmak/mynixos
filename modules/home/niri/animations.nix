{ lib, ... }:

{
  options.my.niri._kdl.animations = lib.mkOption {
    type = lib.types.lines;
    internal = true;
  };

  config.my.niri._kdl.animations = ''
    animations {
    }
  '';
}
