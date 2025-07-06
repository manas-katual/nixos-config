#
#  Sway Configuration
#  Enable with "sway.enable = true;"
#
{
  config,
  lib,
  pkgs,
  userSettings,
  host,
  ...
}:
with lib;
with host; {
  config = mkIf (config.sway.enable) {
    wlwm.enable = true;

    environment = {
      loginShellInit = ''
         if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
         exec sway
        fi
      '';
      variables = {
        WLR_NO_HARDWARE_CURSORS = "1";
      };
      sessionVariables = {
        XDG_CURRENT_DESKTOP = "sway";
        XDG_SESSION_DESKTOP = "sway";
      };
    };

    programs = {
      sway = {
        enable = true;
        extraPackages = with pkgs; [
          autotiling
          libnotify
          jq
        ];
      };
      xwayland.enable = true;
      light = {
        enable = true;
      };
    };

    home-manager.users.${userSettings.username} = {
      wayland.windowManager.sway = {
        enable = true;
        config = rec {
          startup = [
            {
              command = "${pkgs.autotiling}/bin/autotiling";
              always = true;
            }
            {command = "${pkgs.blueman}/bin/blueman-applet";}
            {command = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";}
          ];

          bars = [
            {command = "${pkgs.waybar}/bin/waybar";}
          ];

          window = {
            titlebar = false;
          };

          gaps = {
            inner = 3;
            outer = 3;
          };

          input = {
            # Input modules: $ man sway-input
            "type:touchpad" = {
              tap = "enabled";
              dwt = "enabled";
              scroll_method = "two_finger";
              middle_emulation = "enabled";
              natural_scroll = "enabled";
            };
            "type:keyboard" = {
              xkb_layout = "in";
              xkb_variant = "eng";
              xkb_numlock = "enabled";
            };
          };
        };
        extraConfig = ''
          exec ${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent
          for_window [title="Authentication Required"] floating enable, resize set 600 200
          exec ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator
          exec ${pkgs.blueman}/bin/blueman-applet
          set $opacity 0.9
          for_window [class=".*"] opacity 0.95
          for_window [app_id=".*"] opacity 0.95
          #for_window [app_id="thunar"] opacity 0.95, floating enable
          for_window [app_id="com.github.weclaw1.ImageRoll"] opacity 0.95, floating enable
          for_window [app_id="kitty"] opacity $opacity
          for_window [title="drun"] opacity $opacity
          #for_window [class="Emacs"] opacity $opacity
          for_window [app_id="pavucontrol"] floating enable, sticky
          for_window [app_id="blueberry.py"] floating enable, sticky
          #for_window [app_id=".blueman-manager-wrapped"] floating enable
          for_window [title="Picture in picture"] floating enable, move position 1205 634, resize set 700 400, sticky enable
        ''; # $ swaymsg -t get_tree or get_outputs
      };
    };
  };
}
