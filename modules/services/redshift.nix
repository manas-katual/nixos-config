#
#  Screen Temperature
#
{
  config,
  lib,
  userSettings,
  ...
}: {
  config = lib.mkIf (config.x11wm.enable) {
    home-manager.users.${userSettings.username} = {
      services = {
        redshift = {
          enable = true;
          temperature.night = 3000;
          latitude = 50.929818;
          longitude = 5.338297;
        };
      };
    };
  };
}
