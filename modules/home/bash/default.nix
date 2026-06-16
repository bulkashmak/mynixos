{ ... }:

{
  programs.bash = {
    enable = true;

    shellAliases = {
      l = "lsd -la";

      ff = "fastfetch";

      lg = "lazygit";
      ld = "lazydocker";

      switch = "~/.nixos/rebuild.sh";

      awgup = "sudo awg-quick up neth";
      awgdown = "sudo awg-quick down neth";
    };

    sessionVariables = {
      LS_COLORS = builtins.readFile ./ls-colors;
    };
  };
}
