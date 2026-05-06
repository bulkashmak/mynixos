{ ... }:

{
  programs.lsd = {
    enable = true;
    enableBashIntegration = true;
  };

  xdg.configFile = {
    "lsd/config.yaml".source = ./config.yaml;
    "lsd/colors.yaml".source = ./colors.yaml;
  };
}
