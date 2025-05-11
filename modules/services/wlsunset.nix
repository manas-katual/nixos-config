{ lib, config, userSettings, ... }:
{
  config = lib.mkIf (config.wlwm.enable) {
    home-manager.users.${userSettings.username} = {
      services.wlsunset = {
        enable = true;
        latitude = 19.2;
        longitude = 73.1;
        temperature = {
          day = 6500;   # Neutral white
          night = 3500; # Warmer tone for eye comfort
        };
        gamma = 0.8;    # Adjusts brightness; lower values reduce brightness
      };
    };
  };
}
