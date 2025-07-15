{
  config,
  userSettings,
  lib,
  ...
}: {
  config = lib.mkIf (config.wlwm.enable && config.sway.enable && userSettings.style == "waybar-dwm") {
    home-manager.users.${userSettings.username} = {
      services.mako = {
        enable = true;
        settings = {
          layer = "overlay";
          actions = true;
          anchor = "top-right";
          border-radius = 0;
          default-timeout = 5000;
          height = 100;
          width = 300;
          icons = true;
          ignore-timeout = false;
          margin = 10;
          markup = true;
        };
      };
    };
  };
}
