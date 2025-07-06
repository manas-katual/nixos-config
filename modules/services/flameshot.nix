#
#  Screenshots
#
{
  config,
  lib,
  userSettings,
  ...
}: {
  config = lib.mkIf (config.x11wm.enable) {
    home-manager.users.${userSettings.username} = {
      services.flameshot = {
        enable = true;
        settings = {
          General = {
            savePath = "/home/${userSettings.username}/Pictures/Screenshots";
            saveAsFileExtension = ".png";
            uiColor = "#2d0096";
            showHelp = "false";
            disabledTrayIcon = "true";
          };
        };
      };
    };
  };
}
