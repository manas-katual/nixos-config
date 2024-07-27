{ config, lib, pkgs, userSettings, ... }:

{
  options = {
    my.desktop.option = lib.mkOption {
      type = lib.types.str;
      default = "hyprland";
    };
  };

  config = {
    my.desktop.option = lib.mkDefault "${userSettings.desktop}";

    wayland.windowManager.hyprland.enable = config.my.desktop.option == "hyprland";

    wayland.windowManager.sway.enable = config.my.desktop.option == "sway";
  
  };
}
