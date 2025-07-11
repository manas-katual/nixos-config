# OSD
#
{
  userSettings,
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.wlwm.enable && userSettings.style == "waybar-cool" || userSettings.style == "waybar-curve" || userSettings.style == "waybar-ddubs" || userSettings.style == "waybar-jake" || userSettings.style == "waybar-jerry" || userSettings.style == "waybar-nekodyke") {
    home-manager.users.${userSettings.username} = {
      services.avizo = {
        enable = true;
        settings = {
          default = {
            time = 1.0;
            y-offset = 0.5;
            fade-in = 0.1;
            fade-out = 0.2;
            padding = 10;
          };
        };
      };
    };
  };
}
