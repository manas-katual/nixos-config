{ config, lib, pkgs, userSettings, host, ... }:

with lib;
{
  options = {
    dwm = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.dwm.enable)
    {
      x11wm.enable = true;

      services = {
	displayManager.defaultSession = "none+dwm";
	libinput = {
	  enable = true;
	  touchpad = {
	    tapping = true;
	  };
	};
        

	xserver = {
	  enable = true;
      xkb = {
        layout = "in";
        variant = "eng";
        #options = "eurosign:e";
      };
	  displayManager = {
	    lightdm = {
	      enable = true;
	    };
	  };
	  windowManager = {
	    dwm = {
	      enable = true;
	      package = pkgs.dwm.overrideAttrs {
                src = ./dwm-config/dwm;
              };
	    };
	  };
	};
      };
      environment.systemPackages = with pkgs; [
        rofi
	(dwmblocks.overrideAttrs {
          src = ./dwm-config/dwmblocks;
          #patches = [ ./my-fix.patch ]; # Or some `fetchPatch` thing
        })
      ];
    };
}
