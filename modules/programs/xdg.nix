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
      portal = lib.mkIf (!config.gnome.enable && !config.cosmic.enable) {
        enable = true;
        extraPortals =
          if config.hyprland.enable
          then [pkgs.xdg-desktop-portal-hyprland]
          else if config.sway.enable
          then [pkgs.xdg.desktop-portal-wlr]
          else [];
        configPackages =
          if config.hyprland.enable
          then [pkgs.hyprland]
          else [];
      };
    };
  };
}
