{
  pkgs,
  config,
  lib,
  userSettings,
  ...
}: let
  # base00 = "0F1419";
  # base01 = "131721";
  # base03 = "3E4B59";
  # base05 = "E6E1CF";
  # base06 = "E6E1CF";
  # base07 = "F3F4F5";
  # base08 = "F07178";
  # base09 = "FF8F40";
  # base0A = "FFB454";
  # base0B = "B8CC52";
  # base0C = "95E6CB";
  # base0D = "59C2FF";
  # base0E = "D2A6FF";
  # base0F = "E6B673";
  base00 = config.lib.stylix.colors.base00;
  base01 = config.lib.stylix.colors.base01;
  base02 = config.lib.stylix.colors.base02;
  base03 = config.lib.stylix.colors.base03;
  base04 = config.lib.stylix.colors.base04;
  base05 = config.lib.stylix.colors.base05;
  base06 = config.lib.stylix.colors.base06;
  base07 = config.lib.stylix.colors.base07;
  base08 = config.lib.stylix.colors.base08;
  base09 = config.lib.stylix.colors.base09;
  base0A = config.lib.stylix.colors.base0A;
  base0B = config.lib.stylix.colors.base0B;
  base0C = config.lib.stylix.colors.base0C;
  base0D = config.lib.stylix.colors.base0D;
  base0E = config.lib.stylix.colors.base0E;
  base0F = config.lib.stylix.colors.base0F;
  modules-center = with config;
    if hyprland.enable == true
    then [
      "pulseaudio"
      "hyprland/workspaces"
      "clock"
    ]
    else if sway.enable == true
    then [
      "pulseaudio"
      "sway/workspaces"
      "clock"
    ]
    else if niri.enable == true
    then [
      "pulseaudio"
      "niri/workspaces"
      "clock"
    ]
    else [];

  commonWorkspaces = {
    format = "<span font='11'>{icon}</span>";
    format-icons = {
      "1" = "1";
      "2" = "2";
      "3" = "3";
      "4" = "4";
      "5" = "5";
      "6" = "6";
      "7" = "7";
      "8" = "8";
      "9" = "9";
      "10" = "10";
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
  config = lib.mkIf (config.wlwm.enable && userSettings.style == "waybar-jerry") {
    home-manager.users.${userSettings.username} = {
      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            height = 30;
            spacing = 4;
            modules-left = ["custom/menu" "hyprland/window"];
            modules-center = modules-center;
            modules-right = ["tray" "idle_inhibitor" "custom/notification" "battery" "custom/powermenu"];
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
            font-size: 16px;
            font-family: JetBrainsMono Nerd Font, Font Awesome, sans-serif;
            font-weight: bold;
          }
          window#waybar {
            /*

              background-color: rgba(26,27,38,0);
              border-bottom: 1px solid rgba(26,27,38,0);
              border-radius: 0px;
              color: #${base0F};
            */

            background-color: rgba(26,27,38,0);
            border-bottom: 1px solid rgba(26,27,38,0);
            border-radius: 0px;
            color: #${base0F};
          }
          #workspaces {
            /*
              Eternal
              background: linear-gradient(180deg, #${base00}, #${base01});
              margin: 5px 5px 5px 0px;
              padding: 0px 10px;
              border-radius: 0px 15px 50px 0px;
              border: 0px;
              font-style: normal;
              color: #${base00};
            */
            background: linear-gradient(45deg, #${base01}, #${base01});
            margin: 5px;
            padding: 0px 1px;
            border-radius: 15px;
            border: 0px;
            font-style: normal;
            color: #${base00};
          }
          #workspaces button {
            padding: 0px 5px;
            margin: 4px 3px;
            border-radius: 15px;
            border: 0px;
            color: #${base00};
            background: linear-gradient(45deg, #${base0D}, #${base0E});
            opacity: 0.5;
            transition: all 0.3s ease-in-out;
          }
          #workspaces button.active {
            padding: 0px 5px;
            margin: 4px 3px;
            border-radius: 15px;
            border: 0px;
            color: #${base00};
            background: linear-gradient(45deg, #${base0D}, #${base0E});
            opacity: 1.0;
            min-width: 40px;
            transition: all 0.3s ease-in-out;
          }
          #workspaces button:hover {
            border-radius: 15px;
            color: #${base00};
            background: linear-gradient(45deg, #${base0D}, #${base0E});
            opacity: 0.8;
          }
          tooltip {
            background: #${base00};
            border: 1px solid #${base0E};
            border-radius: 10px;
          }
          tooltip label {
            color: #${base07};
          }
          #window {
            /*
              Eternal
              color: #${base05};
              background: #${base00};
              border-radius: 15px;
              margin: 5px;
              padding: 2px 20px;
            */
            margin: 5px;
            padding: 2px 20px;
            color: #${base05};
            background: #${base01};
            border-radius: 50px 15px 50px 15px;
          }
          #memory {
            color: #${base0F};
            /*
              Eternal
              background: #${base00};
              border-radius: 50px 15px 50px 15px;
              margin: 5px;
              padding: 2px 20px;
            */
            background: #${base01};
            margin: 5px;
            padding: 2px 20px;
            border-radius: 15px 50px 15px 50px;
          }
          #clock {
            color: #${base0B};
              background: #${base00};
              border-radius: 15px 50px 15px 50px;
              margin: 5px;
              padding: 2px 20px;
          }
          #idle_inhibitor {
            color: #${base0A};
              background: #${base00};
              border-radius: 50px 15px 50px 15px;
              margin: 5px;
              padding: 2px 20px;
          }
          #cpu {
            color: #${base07};
              background: #${base00};
              border-radius: 50px 15px 50px 15px;
              margin: 5px;
              padding: 2px 20px;
          }
          #disk {
            color: #${base0F};
              background: #${base00};
              border-radius: 15px 50px 15px 50px;
              margin: 5px;
              padding: 2px 20px;
          }
          #battery {
            color: #${base08};
            background: #${base00};
            border-radius: 15px 50px 15px 50px;
            margin: 5px;
            padding: 2px 20px;
          }
          #network {
            color: #${base09};
            background: #${base00};
            border-radius: 50px 15px 50px 15px;
            margin: 5px;
            padding: 2px 20px;
          }
          #tray {
            color: #${base05};
            background: #${base00};
            border-radius: 15px 50px 15px 50px;
            margin: 5px;
            padding: 2px 20px;
          }
          #pulseaudio {
            color: #${base0D};
            /*
              Eternal
              background: #${base00};
              border-radius: 15px 50px 15px 50px;
              margin: 5px;
              padding: 2px 20px;
            */
            background: #${base01};
            margin: 4px;
            padding: 2px 20px;
            border-radius: 50px 15px 50px 15px;
          }
          #custom-notification {
            color: #${base0C};
            background: #${base00};
            border-radius: 15px 50px 15px 50px;
            margin: 5px;
            padding: 2px 20px;
          }
          #custom-menu {
            color: #${base0E};
            background: #${base00};
            border-radius: 0px 15px 50px 0px;
            margin: 5px 5px 5px 0px;
            padding: 2px 20px;
          }
          #idle_inhibitor {
            color: #${base09};
            background: #${base00};
            border-radius: 15px 50px 15px 50px;
            margin: 5px;
            padding: 2px 20px;
          }
          #custom-powermenu {
            color: #${base0E};
            background: #${base00};
            border-radius: 15px 0px 0px 50px;
            margin: 5px 0px 5px 5px;
            padding: 2px 20px;
          }
        '';
      };
    };
  };
}
