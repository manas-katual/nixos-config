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
      portal = {
        enable = true;
        extraPortals = [inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland];
        configPackages = [inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland];
      };
    };
  };
}
