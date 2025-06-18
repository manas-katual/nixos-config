#
#  Widget
#
{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}: {
  config = lib.mkIf (config.wlwm.enable && userSettings.style == "waybar-oglo") {
    environment.systemPackages = with pkgs; [
      eww # Widgets
      jq # JSON Processor
      socat # Data Transfer
      brightnessctl
      # procps # uptime tool
    ];

    home-manager.users.${userSettings.username} = {
      home.file.".config/eww" = {
        source = ./eww;
        recursive = true;
      };
      home.file.".config/eww/themes/current.scss" = {
        source = ./eww/themes/_${userSettings.theme}.scss;
      };
    };
  };
}
