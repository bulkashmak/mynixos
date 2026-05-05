{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;

      theme = "Monokai Remastered";

      background-opacity = 0.75;
      background-blur-radius = 20;

      gtk-titlebar = false;

      keybind = [
        "ctrl+shift+h=unbind"
        "ctrl+shift+j=unbind"
        "ctrl+shift+k=unbind"
        "ctrl+shift+l=unbind"
      ];
    };

    themes.dankcolors = {
      background = "#1a120e";
      foreground = "#f0dfd8";
      cursor-color = "#ff6d00";
      selection-background = "#3e2723";
      selection-foreground = "#f0dfd8";
      palette = [
        "0=#1a120e"
        "1=#ff1d07"
        "2=#2cff00"
        "3=#ffd100"
        "4=#f26700"
        "5=#763200"
        "6=#ff6d00"
        "7=#ffede0"
        "8=#a5978c"
        "9=#ff493f"
        "10=#6bff4c"
        "11=#ffdf4c"
        "12=#ff8226"
        "13=#ff984c"
        "14=#ffbd8c"
        "15=#fff7f2"
      ];
    };
  };
}
