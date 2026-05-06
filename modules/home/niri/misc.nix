{ lib, ... }:

{
  options.my.niri._kdl.misc = lib.mkOption {
    type = lib.types.lines;
    internal = true;
  };

  config.my.niri._kdl.misc = ''
    prefer-no-csd

    spawn-at-startup "vicinae" "server"

    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    hotkey-overlay {
        skip-at-startup
    }

    workspace "1"
    workspace "2"
    workspace "3"
    workspace "4"
    workspace "5"
    workspace "6"
    workspace "7"
    workspace "8"
    workspace "9"
  '';
}
