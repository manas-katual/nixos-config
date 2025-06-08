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
      };
      portal = lib.mkIf (config.hyprland.enable) {
        enable = true;
        extraPortals = [inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland];
        configPackages = [inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland];
      };
    };
  };
}
