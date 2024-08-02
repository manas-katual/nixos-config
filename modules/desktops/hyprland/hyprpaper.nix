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
}
