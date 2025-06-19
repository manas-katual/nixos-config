{
  pkgs,
  config,
  lib,
  userSettings,
  ...
}: let
  modules-left = with config;
    if hyprland.enable == true
    then [
      "hyprland/workspaces"
    ]
    else if sway.enable == true
    then [
      "sway/workspaces"
    ]
    else if niri.enable == true
    then [
      "niri/workspaces"
    ]
    else [];

  commonWorkspaces = {
    format = "<span font='11'>{icon}</span>";
    format-icons = {
      "1" = " ";
      "2" = " ";
      "3" = " ";
      "4" = " ";
      "5" = " ";
      "6" = " ";
      "7" = " ";
      "8" = " ";
      "9" = " ";
      "10" = " ";
    };
    all-outputs = true;
    persistent_workspaces = {
      "1" = [];
      "2" = [];
      "3" = [];
      "4" = [];
      "5" = [];
      "6" = [];
      "7" = [];
      "8" = [];
      "9" = [];
      "10" = [];
    };
    active-only = false;
    on-click = "activate";
  };
in {
  config = lib.mkIf (config.wlwm.enable && userSettings.style == "waybar-jake") {
    home-manager.users.${userSettings.username} = {
      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            margin = "7 7 3 7";
            height = 30;
            # spacing = 4;
            modules-left = modules-left;
            modules-center = ["clock"];
            modules-right = ["pulseaudio" "custom/notification" "battery" "tray" "custom/powermenu"];
            "sway/workspaces" = commonWorkspaces;
            "niri/workspaces" = commonWorkspaces;
            "wlr/workspaces" = {
              format = "<span font='11'>{name}</span>";
              active-only = false;
              on-click = "activate";
            };
            "hyprland/workspaces" = {
              #format = "<span font='11'>{name}</span>";
              active-only = false;
              on-click = "activate";
              on-scroll-up = "hyprctl dispatch workspace e-1";
              on-scroll-down = "hyprctl dispatch workspace e+1";
              disable-scroll = "false";
            };

            "idle_inhibitor" = {
              format = "{icon}";
              format-icons = {
                "activated" = "󰅶";
                "deactivated" = "󰾪";
              };
            };

            "tray" = {
              spacing = 8;
            };

            "clock" = {
              tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
              format = "󱑏 {:%H:%M}";
              format-alt = " {:%A, %B %d, %Y}";
            };

            "cpu" = {
              format = " {usage}%";
              tooltip = "false";
            };

            "memory" = {
              format = " {}%";
            };

            "backlight" = {
              format = "{icon}{percent}%";
              format-icons = ["󰃞 " "󰃟 " "󰃠 "];
              on-scroll-down = "${pkgs.light}/bin/light -U 5";
              on-scroll-up = "${pkgs.light}/bin/light -A 5";
            };

            "battery" = {
              states = {
                warning = "30";
                critical = "15";
              };
              format = "{capacity}% {icon}";
              tooltip-format = "{timeTo} {capacity}%";
              format-charging = "{capacity}% ";
              format-plugged = " ";
              format-alt = "{time} {icon}";
              format-icons = [" " " " " " " " " "];
            };

            "network" = {
              format-wifi = "󰒢 ";
              format-ethernet = "{ifname}: {ipaddr}/{cidr}  ";
              format-linked = "{ifname} (No IP)  ";
              format-disconnected = "󰞃 ";
              on-click = "kitty nmtui";
              on-click-release = "sleep 0";
              tooltip-format = "{essid} {signalStrength}%";
            };

            "bluetooth" = {
              device = "intel_backlight";
              format = "{icon}";
              format-alt = "{status}";
              interval = 30;
              on-click-right = "${pkgs.blueberry}/bin/blueberry";
              "format-icons" = {
                enabled = "";
                disabled = "󰂲";
              };
              tooltip-format = "{status}";
            };

            "pulseaudio" = {
              format = "{icon} {volume}% {format_source}";
              format-bluetooth = "{icon} {volume}%";
              format-bluetooth-muted = "   {volume}%";
              format-source = " ";
              format-source-muted = " ";
              format-muted = "  {format_source}";
              format-icons = {
                headphone = " ";
                hands-free = " ";
                headset = " ";
                phone = " ";
                portable = " ";
                car = " ";
                default = [" " " " " "];
              };
              tooltip-format = "{desc} {volume}%";
              on-click = "${pkgs.pamixer}/bin/pamixer -t";
              on-click-right = "${pkgs.pamixer}/bin/pamixer --default-source -t";
              on-click-middle = "${pkgs.pavucontrol}/bin/pavucontrol";
              on-click-middle-release = "sleep 0";
            };

            "custom/notification" = {
              tooltip = false;
              format = "{icon} ";
              format-icons = {
                notification = "<span foreground='red'><sup></sup></span>";
                none = "";
                dnd-notification = "<span foreground='red'><sup></sup></span>";
                dnd-none = "";
                inhibited-notification = "<span foreground='red'><sup></sup></span>";
                inhibited-none = "";
                dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
                dnd-inhibited-none = "";
              };
              return-type = "json";
              exec-if = "which swaync-client";
              exec = "swaync-client -swb";
              #on-click = "sleep 0.1 && task-waybar";
              on-click = "sleep 0.1; swaync-client -t -sw";
              on-click-right = "sleep 0.1; swaync-client -d -sw";
              escape = true;
            };

            "custom/menu" = {
              format = " ";
              on-click = "sleep 0.1 && ${pkgs.rofi-wayland}/bin/rofi -show drun";
              tooltip = false;
            };

            "custom/powermenu" = {
              format = "⏻ ";
              on-click = "sleep 0.1 && ${pkgs.wlogout}/bin/wlogout -b 2 --protocol layer-shell";
              tooltip = false;
            };
          };
        };
        style = ''

          * {
              border: none;
              border-radius: 0;
              font-family: JetBrainsMono Nerd Font, FontAwesome, Roboto, Helvetica, Arial, sans-serif;
              font-size: 16px;
              min-height: 0px;
          }

          window#waybar {
              background: transparent;
          }

          window#waybar.hidden {
              opacity: 0.02;
          }

          #workspaces {
              margin-right: 8px;
              padding-left: 16px;
              border-radius: 10px 20px 5px 10px;
              transition: none;
              background: #${config.lib.stylix.colors.base00};
              border: solid 1px;
              border-color: #${config.lib.stylix.colors.base02};
          }

          #workspaces button {
              transition: none;
              color: #${config.lib.stylix.colors.base05};
              background: transparent;
              padding: 5px;
              font-size: 18px;
          }

          #workspaces button.persistent {
              color: #${config.lib.stylix.colors.base09};
              font-size: 12px;
          }

          #workspaces button.active {
              color: #${config.lib.stylix.colors.base0D};
          }

          /* hover removed per your comment-out */

          #language {
              padding-left: 16px;
              padding-right: 8px;
              border-radius: 10px 0px 0px 10px;
              transition: none;
              color: #${config.lib.stylix.colors.base05};
              background: #${config.lib.stylix.colors.base02};
          }

          #keyboard-state {
              margin-right: 8px;
              padding-right: 16px;
              border-radius: 0px 10px 10px 0px;
              transition: none;
              color: #${config.lib.stylix.colors.base05};
              background: #${config.lib.stylix.colors.base02};
          }

          #custom-updates {
              padding-left: 16px;
              padding-right: 16px;
              border-radius: 5px 20px 5px 20px;
              border: solid 1px;
              border-color: #${config.lib.stylix.colors.base02};
              transition: none;
              color: #${config.lib.stylix.colors.base05};
              background: #${config.lib.stylix.colors.base00};
          }

          #custom-notification {
              margin-right: 8px;
              padding-left: 16px;
              padding-right: 16px;
              border-radius: 20px 5px 20px 5px;
              border: solid 1px;
              border-color: #${config.lib.stylix.colors.base02};
              color: #${config.lib.stylix.colors.base0D};
              background: #${config.lib.stylix.colors.base00};
          }

          #custom-mail {
              margin-right: 8px;
              padding-right: 16px;
              border-radius: 0px 10px 10px 0px;
              transition: none;
              color: #${config.lib.stylix.colors.base05};
              background: #${config.lib.stylix.colors.base02};
          }

          #mode {
              padding-left: 16px;
              padding-right: 16px;
              border-radius: 10px;
              transition: none;
              color: #${config.lib.stylix.colors.base05};
              background: #${config.lib.stylix.colors.base02};
          }

          #clock {
              padding-left: 16px;
              padding-right: 16px;
              border-radius: 10px 10px 10px 10px;
              border: solid 2px;
              border-color: #000000;
              transition: none;
              color: #000000;
              background: #${config.lib.stylix.colors.base02};
          }

          #custom-weather {
              padding-right: 16px;
              border-radius: 0px 10px 10px 0px;
              transition: none;
              color: #${config.lib.stylix.colors.base05};
              background: #${config.lib.stylix.colors.base02};
          }

          #pulseaudio {
              margin-right: 8px;
              padding-left: 16px;
              padding-right: 16px;
              border-radius: 20px 5px 20px 5px;
              border: solid 1px;
              border-color: #${config.lib.stylix.colors.base02};
              transition: none;
              color: #${config.lib.stylix.colors.base05};
              background: #${config.lib.stylix.colors.base00};
          }

          #pulseaudio.muted {
              background-color: #${config.lib.stylix.colors.base0C};
              color: #${config.lib.stylix.colors.base0B};
          }

          #custom-mem {
              margin-right: 8px;
              padding-left: 16px;
              padding-right: 16px;
              border-radius: 10px;
              transition: none;
              color: #${config.lib.stylix.colors.base05};
              background: #${config.lib.stylix.colors.base02};
          }

          #temperature {
              margin-right: 8px;
              padding-left: 16px;
              padding-right: 16px;
              border-radius: 10px;
              transition: none;
              color: #${config.lib.stylix.colors.base05};
              background: #${config.lib.stylix.colors.base02};
          }

          #temperature.critical {
              background-color: #${config.lib.stylix.colors.base08};
          }

          #backlight {
              margin-right: 8px;
              padding-left: 16px;
              padding-right: 16px;
              border-radius: 20px 5px 20px 5px;
              border: solid 1px;
              border-color: #${config.lib.stylix.colors.base02};
              transition: none;
              color: #${config.lib.stylix.colors.base05};
              background: #${config.lib.stylix.colors.base00};
          }

          #battery {
              margin-right: 8px;
              padding-left: 16px;
              padding-right: 16px;
              border-radius: 20px 5px 20px 5px;
              border: solid 1px;
              border-color: #${config.lib.stylix.colors.base02};
              transition: none;
              color: #${config.lib.stylix.colors.base05};
              background: #${config.lib.stylix.colors.base00};
          }

          #battery.charging {
              color: #${config.lib.stylix.colors.base05};
              background-color: #${config.lib.stylix.colors.base00};
              border: solid 1px;
              border-color: #${config.lib.stylix.colors.base0D};
          }

          #battery.warning:not(.charging) {
              background-color: #${config.lib.stylix.colors.base00};
              color: #${config.lib.stylix.colors.base05};
              border-color: #${config.lib.stylix.colors.base0A};
          }

          #battery.critical:not(.charging) {
              background-color: #${config.lib.stylix.colors.base00};
              color: #${config.lib.stylix.colors.base05};
              border-color: #${config.lib.stylix.colors.base08};
              animation-name: blink;
              animation-duration: 0.5s;
              animation-timing-function: linear;
              animation-iteration-count: infinite;
              animation-direction: alternate;
          }

          #tooltip {
              background-color: #${config.lib.stylix.colors.base00};
          }

          #tray {
              margin-right: 8px;
              padding-left: 16px;
              padding-right: 16px;
              border-radius: 20px 5px 20px 5px;
              border: solid 1px;
              border-color: #${config.lib.stylix.colors.base02};
              color: #${config.lib.stylix.colors.base0D};
              background: #${config.lib.stylix.colors.base00};
          }

          #custom-powermenu {
              padding-left: 16px;
              padding-right: 16px;
              border-radius: 20px 10px 10px 5px;
              border: solid 1px;
              border-color: #${config.lib.stylix.colors.base02};
              transition: none;
              color: #${config.lib.stylix.colors.base05};
              background: #${config.lib.stylix.colors.base00};
          }

          @keyframes blink {
              to {
                  background-color: #ffffff;
                  color: #000000;
              }
          }
        '';
      };
    };
  };
}
