{ pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;

    settings = {
      ipc = "on";
      splash = false;

    preload = [
      "~/setup/modules/wallpapers/random.jpg"
      "~/setup/modules/wallpapers/hut.jpg"
      "~/setup/modules/wallpapers/car.jpg"
      "~/setup/modules/wallpapers/sky.jpg"
      "~/setup/modules/wallpapers/nord_roads.png"
      "~/setup/modules/wallpapers/nord_lake.png"
      "~/setup/modules/wallpapers/nord_bridge.png"
      "~/setup/modules/wallpapers/nixos.png"
      "~/setup/modules/wallpapers/ledge_gruvbox.png"
      "~/setup/modules/wallpapers/hyprland.png"
      "~/setup/modules/wallpapers/ghibli_insider.jpeg"
      "~/setup/modules/wallpapers/wind_rises.jpeg"
    ];

    wallpaper = [
      "LVDS-1,~/setup/modules/wallpapers/random.jpg"
      "LVDS-1,~/setup/modules/wallpapers/hut.jpg"
      "LVDS-1,~/setup/modules/wallpapers/car.jpg"
      "LVDS-1,~/setup/modules/wallpapers/sky.jpg"
      "LVDS-1,~/setup/modules/wallpapers/nord_roads.png"
      "LVDS-1,~/setup/modules/wallpapers/nord_lake.png"
      "LVDS-1,~/setup/modules/wallpapers/nord_bridge.png"
      "LVDS-1,~/setup/modules/wallpapers/nixos.png"
      "LVDS-1,~/setup/modules/wallpapers/ledge_gruvbox.png"
      "LVDS-1,~/setup/modules/wallpapers/hyprland.png"
      "LVDS-1,~/setup/modules/wallpapers/ghibli_insider.jpeg"
      "LVDS-1,~/setup/modules/wallpapers/wind_rises.jpeg"
    ];
    };
  };
#  home.file.".config/hypr/hyprpaper.conf".text = ''
#  preload = ~/setup/modules/wallpapers/random.jpg
#  preload = ~/setup/modules/wallpapers/hut.jpg
#  preload = ~/setup/modules/wallpapers/car.jpg
#  preload = ~/setup/modules/wallpapers/sky.jpg
#  preload = ~/setup/modules/wallpapers/nord_roads.png
#  preload = ~/setup/modules/wallpapers/nord_lake.png
#  preload = ~/setup/modules/wallpapers/nord_bridge.png
#  preload = ~/setup/modules/wallpapers/nixos.png
#  preload = ~/setup/modules/wallpapers/ledge_gruvbox.png
#  preload = ~/setup/modules/wallpapers/hyprland.png
#  preload = ~/setup/modules/wallpapers/ghibli_insider.jpeg
#  preload = ~/setup/modules/wallpapers/wind_rises.jpeg

#  wallpaper = LVDS-1,~/setup/modules/wallpapers/random.jpg
#  wallpaper = LVDS-1,~/setup/modules/wallpapers/hut.jpg
#  wallpaper = LVDS-1,~/setup/modules/wallpapers/car.jpg
#  wallpaper = LVDS-1,~/setup/modules/wallpapers/sky.jpg
#  wallpaper = LVDS-1,~/setup/modules/wallpapers/nord_roads.png
#  wallpaper = LVDS-1,~/setup/modules/wallpapers/nord_lake.png
#  wallpaper = LVDS-1,~/setup/modules/wallpapers/nord_bridge.png
#  wallpaper = LVDS-1,~/setup/modules/wallpapers/nixos.png
#  wallpaper = LVDS-1,~/setup/modules/wallpapers/ledge_gruvbox.png
#  wallpaper = LVDS-1,~/setup/modules/wallpapers/hyprland.png
#  wallpaper = LVDS-1,~/setup/modules/wallpapers/ghibli_insider.jpeg
#  wallpaper = LVDS-1,~/setup/modules/wallpapers/wind_rises.jpeg
  
#  ipc = on
#  splash = false
#  '';
}
