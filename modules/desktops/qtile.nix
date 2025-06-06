{
  config,
  lib,
  userSettings,
  pkgs,
  ...
}:
with lib; {
  options = {
    qtile = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config =
    mkIf (config.qtile.enable)
    {
      x11wm.enable = true;

      services = {
        xserver = {
          enable = true;
          windowManager = {
            qtile = {
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
          defaultSession = "qtile";
        };
        libinput = {
          enable = true;
          touchpad = {
            tapping = true;
          };
        };
      };

      environment.systemPackages = with pkgs; [
        xclip
      ];

      home-manager.users.${userSettings.username} = {
        xdg.configFile."qtile" = {
          source = ./qtile;
          recursive = true;
        };
      };
    };
}
