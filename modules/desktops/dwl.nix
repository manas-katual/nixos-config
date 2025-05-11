{ config, lib, pkgs, userSettings, host, ... }:

with lib;
with host;
{
  options = {
    dwl = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.dwl.enable) {
    wlwm.enable = true;

    environment = {
      loginShellInit = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
          exec dwl 
          dwl -s 'dwlb -font "monospace:size=16"'
        fi
      '';

      variables = {
        # LIBCL_ALWAYS_SOFTWARE = "1"; # Needed for VM
        # WLR_NO_HARDWARE_CURSORS = "1";
      };
      systemPackages = with pkgs; [
        dwl # Window Manager
        wev # Event Viewer
        wl-clipboard # Clipboard
        wlr-randr # Monitor Settings
        xdg-desktop-portal-wlr # Wayland portal
        xwayland # X for Wayland
        foot
        wlr-protocols
        dwlb
      ];
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      config.common.default = "*";
    };

    # home-manager.users.${userSettings.username} = {
    #   home.packages = [
    #     pkgs.dwl
    #     (pkgs.dwl.override {
    #       configH = ./dwl-config/dwl/config.h;
    #     })
    #     pkgs.somebar
    #   ];
    #   home.file = {
    #   };
    # };

      # nixpkgs.overlays = [ 
      #   ( final: prev: 
      #     { dwl = prev.dwl.overrideAttrs 
      #       { configH = [ ./dwl-config/dwl/config.h ]; 
      #       }; 
      #     }) 
      # ];

  nixpkgs.overlays = [
    (
      final: prev:
        {
          dwl = prev.dwl.override { configH = ./dwl-config/dwl/config.h; };
        }
    )

    # (final: prev: {
    #   dwlb = prev.dwlb.overrideAttrs (old: {
    #     src = ./dwl-config/dwlb; # your patched dwlb source dir
    #   });
    # })

  ];

  };
}
