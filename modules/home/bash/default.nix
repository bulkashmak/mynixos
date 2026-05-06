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
    };

    sessionVariables = {
      LS_COLORS = builtins.readFile ./ls-colors;
    };
  };
}
