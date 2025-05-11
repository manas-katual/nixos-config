{ config, lib, userSettings, ... }:

{
  config = lib.mkIf (config.laptop.enable && config.gnome.enable == false) {
    services = {
      # tlp
      tlp = {
        enable = false; # Disable due to suspend not working when docked and connected to AC
        settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 20;

          # Optional helps save long term battery health
          START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
          STOP_CHARGE_THRESH_BAT0 = 80;  # 80 and above it stops charging
        };
      };

      # auto-cpufreq
      auto-cpufreq = {
        enable = true; # Power Efficiency
        settings = {
          battery = {
            governor = "powersave";
            turbo = "never";
          };
          charger = {
            governor = "performance";
            turbo = "auto";
          };
        };
      };

      upower.enable = true; # to check battery statistics and reporting
      thermald.enable = true; # prevents overheating on Intel CPUs
    };

    # nixos default ppower management tool
    powerManagement = {
      enable = false;
      cpuFreqGovernor = "powersave";
      powertop.enable = false;
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
