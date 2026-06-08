{ ... }:

let
  wallpaper = ../../static/wallpapers/starship.jpg;
in
{
  programs.noctalia-shell = {
    enable = true;

    settings = {
      wallpaper = {
        enabled = true;
        default.path = toString wallpaper;
      };
    };
  };
}
