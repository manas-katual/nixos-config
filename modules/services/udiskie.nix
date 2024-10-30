#
#  Mounting tool
#

{ userSettings, ... }:

{
  home-manager.users.${userSettings.username} = {
    services = {
      udiskie = {
        enable = true;
        automount = true;
        tray = "auto";
      };
    };
  };
}
