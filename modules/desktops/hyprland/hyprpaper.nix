{
  config,
  pkgs,
  lib,
  userSettings,
  ...
}:
with lib; {
  config = mkIf (config.hyprland.enable) {
    wlwm.enable = true;
    home-manager.users.${userSettings.username} = {
      services.hyprpaper = {
        enable = true;
        settings = {
          ipc = true;
          splash = false;
          preload = [''+config.stylix.image+''];
          wallpaper = [''+config.stylix.image+''];
        };
      };
    };
  };
}
