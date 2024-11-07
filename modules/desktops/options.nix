{ lib, ... }:

with lib;
{
  options = {
    x11wm = {
      enable = mkOption {
        type = types.bool;
	default = false;
      };
    };
    wlwm = {
      enable = mkOption {
        type = types.bool;
	default = false;
      };
    };
  };
}
