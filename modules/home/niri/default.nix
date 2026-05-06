{ config, lib, ... }:

let
  cfg = config.my.niri;
in
{
  imports = [
    ./input.nix
    ./layout.nix
    ./binds.nix
    ./window-rules.nix
    ./animations.nix
    ./misc.nix
  ];

  options.my.niri = {
    outputs = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Per-host raw KDL block for `output` declarations.";
    };
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra raw KDL appended at the end of niri config.";
    };
  };

  config = {
    programs.niri.config = lib.mkForce (lib.concatStringsSep "\n" [
      cfg._kdl.misc
      cfg._kdl.input
      cfg._kdl.layout
      cfg._kdl.animations
      cfg._kdl.windowRules
      cfg._kdl.binds
      cfg.outputs
      cfg.extraConfig
    ]);
  };
}
