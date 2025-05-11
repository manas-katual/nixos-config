{ config, lib, ... }:

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

      services = {
        xserver = {
          enable = true;
          windowManager = {
            jwm = {
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
            defaultSession = "none+jwm";
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
