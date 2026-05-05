{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      # Font
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;
      # Theme
      #theme = "GruvboxDark";
      window-decoration = false;
      #window-padding-x = 8;
      #window-padding-y = 8;
      #cursor-style = "block";
      #shell-integration = "bash";
      background-opacity = 0.75;
      background-blur-radius = 20;
      # Binds
      ## Unbind tmux/nvim
      #keybind = ctrl+shift+h=unbind
      #keybind = ctrl+shift+j=unbind
      #keybind = ctrl+shift+k=unbind
      #keybind = ctrl+shift+l=unbind
    };
  };
}
