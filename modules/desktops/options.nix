{ lib, ... }:

with lib;
{
  options = {
    x11wm = {
      # Condition if host uses an X11 window manager
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    wlwm = {
      # Condition if host uses a wayland window manager
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    laptop = {
      # Condition if host is a laptop
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
}
