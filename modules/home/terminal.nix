{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      theme = "GruvboxDark";
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;
      window-padding-x = 8;
      window-padding-y = 8;
      window-decoration = false;
      cursor-style = "block";
      shell-integration = "bash";
    };
  };
}
