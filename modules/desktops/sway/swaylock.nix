#
#  Sway Configuration
#  Enable with "sway.enable = true;"
#
{
  config,
  lib,
  pkgs,
  userSettings,
  host,
  ...
}:
with lib;
with host; {
  config = mkIf (config.sway.enable) {
    home-manager.users.${userSettings.username} = {
      programs.swaylock = {
        enable = true;
        package = pkgs.swaylock-effects;
        settings = {
          color = lib.mkForce "#''+stylix.colors.base04+''";
          clock = true;
          font-size = 24;
          fade-in = 0.2;
          grace = 5;
          indicator-idle-visible = true;
          indicator-radius = 100;
          line-color = lib.mkForce "#''+stylix.colors.base00+''";
          show-failed-attempts = true;
        };
      };
    };
  };
}
