{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:
with lib; {
  options = {
    cosmic = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.cosmic.enable) {
    services = {
      libinput.enable = true;
      displayManager.cosmic-greeter.enable = true;
      desktopManager.cosmic.enable = true;
      desktopManager.cosmic.xwayland.enable = true;
    };

    environment = {
      systemPackages = with pkgs; [
      ];
    };

    home-manager.users.${userSettings.username} = {
    };
  };
}
