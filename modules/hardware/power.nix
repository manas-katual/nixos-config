{
  config,
  lib,
  userSettings,
  ...
}: {
  config = lib.mkIf (config.laptop.enable && config.gnome.enable == false) {
    services = {
      auto-cpufreq = {
        enable = true; # Power Efficiency
      };

      upower.enable = true; # to check battery statistics and reporting
      thermald.enable = userSettings.cpu == "intel"; # prevents overheating on Intel CPUs
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
