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

    programs.hyprland.enable = config.my.desktop.option == "hyprland";

    programs.wayfire.enable = config.my.desktop.option == "wayfire";

    programs.sway.enable = config.my.desktop.option == "sway";

    services.xserver.windowManager.dwm.enable = config.my.desktop.option == "dwm";

    services.xserver.desktopManager.gnome.enable = config.my.desktop.option == "gnome";

    services.xserver.desktopManager.pantheon.enable = config.my.desktop.option == "pantheon";
   
    services.desktopManager.plasma6.enable = config.my.desktop.option == "kde";

    #services.desktopManager.cosmic.enable = config.my.desktop.option == "cosmic";
  };
}

