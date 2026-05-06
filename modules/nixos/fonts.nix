{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    inter
    fira-code
    fira-code-symbols
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [ "JetBrainsMono Nerd Font" "Fira Code" ];
    sansSerif = [ "Inter" ];
    serif = [ "Noto Serif" ];
  };
}
