{
  config,
  lib,
  pkgs,
  userSettings,
  host,
  ...
}:
with lib; {
  options = {
    dwm = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config =
    mkIf (config.dwm.enable)
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
              package =
                (pkgs.dwm.override {
                  patches = [
                    (pkgs.fetchpatch {
                      url = "https://dwm.suckless.org/patches/pertag/dwm-pertag-20200914-61bb8b2.diff";
                      hash = "sha256-wRZP/27V7xYOBnFAGxqeJFXdoDk4K1EQMA3bEoAXr/0=";
                    })
                  ];
                }).overrideAttrs (oldAttrs: {
                  src = ./dwm-config/dwm; # Your local source with edited config.h
                });
            };
          };
        };
      };
      environment.systemPackages = with pkgs; [
        rofi
        # (dwmblocks.overrideAttrs {
        #   src = ./dwm-config/dwmblocks;
        #   #patches = [ ./my-fix.patch ]; # Or some `fetchPatch` thing
        # })
      ];
    };
}
