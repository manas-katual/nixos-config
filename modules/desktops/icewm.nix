{ config, lib, ... }:

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

      services = {
        xserver = {
          enable = true;
          windowManager = {
            icewm = {
              enable = true;
            };
          };
          displayManager = {
            lightdm = {
              enable = true;
            };
          };
        };
        displayManager = {
            defaultSession = "none+icewm";
        };
        libinput = {
          enable = true;
          touchpad = {
            tapping = true;
          };
        };
      };
    };
}
