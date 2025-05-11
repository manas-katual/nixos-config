{ pkgs, userSettings, ... }:

{
  home-manager.users.${userSettings.username} = {
    xdg = {
      enable = true;
      mime.enable = true;
      mimeApps = {
        enable = true;
      };
      portal = {
        enable = true;
        extraPortals = [pkgs.xdg-desktop-portal-hyprland];
        configPackages = [pkgs.hyprland];
      };
    };
  };
}

