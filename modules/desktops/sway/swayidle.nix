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
      services.swayidle = {
        enable = true;
        events = [
          {
            event = "before-sleep";
            command = "${pkgs.swaylock-effects}/bin/swaylock --daemonize";
          }
          {
            event = "lock";
            command = "${pkgs.swaylock-effects}/bin/swaylock --daemonize --grace 0";
          }
          {
            event = "unlock";
            command = "pkill -SIGUSR1 swaylock";
          }
          {
            event = "after-resume";
            command = "swaymsg \"output * dpms on\"";
          }
        ];
        timeouts = [
          {
            timeout = 1800;
            command = "${pkgs.swaylock-effects}/bin/swaylock --daemonize";
          }
          {
            timeout = 2000;
            command = "swaymsg \"output * dpms off\"";
            resumeCommand = "swaymsg \"output * dpms on\"";
          }
        ];
      };
    };
  };
}
