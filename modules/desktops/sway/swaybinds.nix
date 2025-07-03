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
    home-manager.users.${userSettings.username} = {
      wayland.windowManager.sway = {
        config = rec {
          modifier = "Mod4";
          terminal = "${pkgs.${userSettings.terminal}}/bin/${userSettings.terminal}";
          menu = "${pkgs.wofi}/bin/wofi --show drun";
          #output = {};

          keybindings = {
            "${modifier}+Escape" = "exec swaymsg exit";
            "${modifier}+Return" = "exec ${terminal}";
            "${modifier}+space" = "exec ${menu}";

            "${modifier}+r" = "reload";
            "${modifier}+q" = "kill";
            "${modifier}+f" = "fullscreen toggle";
            "${modifier}+h" = "floating toggle";

            "${modifier}+Left" = "focus left";
            "${modifier}+Right" = "focus right";
            "${modifier}+Up" = "focus up";
            "${modifier}+Down" = "focus down";

            "${modifier}+TAB" = "exec pkill -SIGUSR1 waybar";
            "${modifier}+W" = "exec pkill waybar && ${pkgs.waybar}/bin/waybar &";

            "${modifier}+1" = "workspace number 1";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";
            "${modifier}+6" = "workspace number 6";
            "${modifier}+7" = "workspace number 7";
            "${modifier}+8" = "workspace number 8";
            "${modifier}+9" = "workspace number 9";

            "${modifier}+Shift+Left" = "move container to workspace prev, workspace prev";
            "${modifier}+Shift+Right" = "move container to workspace next, workspace next";

            "${modifier}+Shift+1" = "move container to workspace number 1";
            "${modifier}+Shift+2" = "move container to workspace number 2";
            "${modifier}+Shift+3" = "move container to workspace number 3";
            "${modifier}+Shift+4" = "move container to workspace number 4";
            "${modifier}+Shift+5" = "move container to workspace number 5";
            "${modifier}+Shift+6" = "move container to workspace number 6";
            "${modifier}+Shift+7" = "move container to workspace number 7";
            "${modifier}+Shift+8" = "move container to workspace number 8";
            "${modifier}+Shift+9" = "move container to workspace number 9";

            "Print" = "exec screenshot";

            "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 10";
            "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 10";
            "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
            "XF86AudioMicMute" = "exec ${pkgs.pamixer}/bin/pamixer --default-source -t";

            "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
            "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl ser 5%-";
          };
        };
      };
    };
  };
}
