{ lib, ... }:

{
  options.my.niri._kdl.input = lib.mkOption {
    type = lib.types.lines;
    internal = true;
  };

  config.my.niri._kdl.input = ''
    input {
        keyboard {
            repeat-rate 35
            repeat-delay 200

            xkb {
                layout "us,ru"
                options "grp:ctrl_space_toggle"
            }

            numlock
        }

        touchpad {
            tap
            natural-scroll
        }

        mouse {
        }

        trackpoint {
        }

        focus-follows-mouse max-scroll-amount="0%"
    }
  '';
}
