#
#  File Browser
#
{
  config,
  userSettings,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (userSettings.file-manager == "pcmanfm") {
    environment.systemPackages = with pkgs; [
      pcmanfm
      shared-mime-info
      lxde.lxmenu-data
    ];
  };
}
