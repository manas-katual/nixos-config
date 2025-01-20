{ config, lib, userSettings, ... }:

{
  config = lib.mkIf (config.laptop.enable && config.gnome.enable == false) {
    services = {
      tlp.enable = false; # Disable due to suspend not working when docked and connected to AC
      auto-cpufreq.enable = true; # Power Efficiency
    };

    home-manager.users.${userSettings.username} = {
      services = {
        cbatticon = {
          enable = true;
          criticalLevelPercent = 10;
          commandCriticalLevel = ''notify-send "battery critical!"'';
          lowLevelPercent = 30;
          iconType = "standard";
        };
      };
    };
  };
}
