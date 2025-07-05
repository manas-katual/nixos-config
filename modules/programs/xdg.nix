{
  pkgs,
  userSettings,
  inputs,
  lib,
  config,
  ...
}: {
  home-manager.users.${userSettings.username} = {
    xdg = {
      enable = true;
      mime.enable = true;
      mimeApps = lib.mkIf (config.gnome.enable == false) {
        enable = true;
        defaultApplications = {
          "default-web-browser" = ["google-chrome-stable.desktop"];
          "image/jpeg" = ["image-roll.desktop" "feh.desktop"];
          "image/png" = ["image-roll.desktop"];
          "text/plain" = "nvim.desktop";
          "text/html" = "nvim.desktop";
          "text/csv" = "nvim.desktop";
        };
      };
      portal = lib.mkIf (config.hyprland.enable) {
        enable = true;
        extraPortals = [pkgs.xdg-desktop-portal-hyprland];
        configPackages = [pkgs.hyprland];
      };
    };
  };
}
