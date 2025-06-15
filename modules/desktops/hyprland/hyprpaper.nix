# don't need this as stylix applies wallpaper
{
  config,
  lib,
  userSettings,
  pkgs,
  ...
}:
with lib; {
  config = mkIf (config.hyprland.enable) {
    environment.systemPackages = with pkgs; [
      hyprpaper
    ];
    wlwm.enable = true;
    home-manager.users.${userSettings.username} = {
      services.hyprpaper = {
        enable = true;
        package = pkgs.hyprpaper;
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
