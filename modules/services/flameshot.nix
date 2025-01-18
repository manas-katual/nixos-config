#
#  Screenshots
#

{ config, lib, userSettings, ... }:

{
  config = lib.mkIf (config.services.xserver.enable) {
    home-manager.users.${userSettings.username} = {
      services.flameshot = {
        enable = true;
        settings = {
          General = {
            savePath = "/home/${userSettings.username}/";
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
