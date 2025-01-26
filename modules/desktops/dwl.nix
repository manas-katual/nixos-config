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
          exec dwl #-s 'dwlb -font "monospace:size=16"'
        fi
      '';

      variables = {
        # LIBCL_ALWAYS_SOFTWARE = "1"; # Needed for VM
        # WLR_NO_HARDWARE_CURSORS = "1";
      };
      systemPackages = with pkgs; [
        dwl # Window Manager
        #(dwl.overrideAttrs {
        #  configH = ./dwl-config/dwl;
        #})

        #(dwlb.overrideAttrs {
        #  configH = ./dwl-config/dwlb;
        #})


        wev # Event Viewer
        wl-clipboard # Clipboard
        wlr-randr # Monitor Settings
        xdg-desktop-portal-wlr # Wayland portal
        xwayland # X for Wayland
      ];
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      config.common.default = "*";
    };

    #home-manager.users.${userSettings.username} = {
    #  home.file = {
    #    "startw" = {
    #	  executable = true;
    #	  text = ''
    #	    #!/bin/sh
    #
    #	    dwl -s 'dwlb <&-'
    #	  '';
    #	};
    #      };
    #    };

  nixpkgs.overlays = [
    (
      final: prev:
        {
          dwl = prev.dwl.override { conf = ./dwl-config/dwl/config.h; };
          dwlb = prev.dwlb.override { conf = ./dwl-config/dwlb/config.h; };
        }
    )
    (
      self: super:
        {
          dwl = super.dwl.overrideAttrs ( oldAttrs: rec { src = ./dwl-config/dwl; });
          dwlb = super.dwlb.overrideAttrs ( oldAttrs: rec { src = ./dwl-config/dwlb; });
        }
    )
  ];

  #nixpkgs.overlays = [
  #  (
  #    self: super:
  #      {
  #        dwl = super.dwl.overrideAttrs ( oldAttrs: rec { src = ./dwl-config/dwl; });
  #        dwlb = super.dwlb.overrideAttrs ( oldAttrs: rec { src = ./dwl-config/dwlb; });
  #      }
  #  )
  #];

  };
}
