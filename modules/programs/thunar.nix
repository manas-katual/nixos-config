#
#  File Browser
#
{
  pkgs,
  userSettings,
  lib,
  ...
}: {
  config = lib.mkIf (userSettings.file-manager == "thunar") {
    programs = {
      xfconf.enable = true;
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-volman
          thunar-media-tags-plugin
        ];
      };
    };

    services = {
      gvfs.enable = true;
      tumbler.enable = true;
    };

    environment.systemPackages = with pkgs; [
      file-roller # archive manager
    ];
  };
}
