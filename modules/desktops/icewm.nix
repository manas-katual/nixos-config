{ config, lib, pkgs, userSettings, host, ... }:

with lib;
{
  options = {
    icewm = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.icewm.enable)
    {
      x11wm.enable = true;

      services.xserver.enable = true;
      services.xserver.windowManager.icewm.enable = true;
      services.xserver.displayManager.lightdm.enable = true;
      services.displayManager.defaultSession = "none+icewm";
      services.libinput = {
        enable = true;
	touchpad = {
	  tapping = true;
	};
      };
    };
}
