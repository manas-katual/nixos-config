# OSD
#
{
  userSettings,
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf (config.wlwm.enable && !config.sway.enable && userSettings.style == "waybar-oglo") {
    home-manager.users.${userSettings.username} = {
      services.swayosd = {
        enable = true;
        package = pkgs.swayosd;
      };
    };
  };
}
