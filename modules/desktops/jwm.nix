{ config, lib, pkgs, userSettings, host, ... }:

with lib;
{
  options = {
    jwm = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.jwm.enable)
    {
      x11wm.enable = true;

      services.xserver.enable = true;
      services.xserver.windowManager.jwm.enable = true;
      services.xserver.displayManager.lightdm.enable = true;
      services.displayManager.defaultSession = "none+jwm";
      services.libinput = {
        enable = true;
	touchpad = {
	  tapping = true;
	};
      };
      environment.systemPackages = [
	pkgs.jwm-settings-manager
      ];
    };
}
