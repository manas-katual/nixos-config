{
  pkgs,
  config,
  lib,
  userSettings,
  ...
}: let
  modules-center = with config;
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
  config = lib.mkIf (config.wlwm.enable && userSettings.style == "waybar-ddubs") {
    home-manager.users.${userSettings.username} = {
      programs.waybar = {
        enable = true;
        package = pkgs.waybar;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            # height = 30;
            # spacing = 4;
            modules-left = ["custom/menu" "custom/window_class" "idle_inhibitor"];
            modules-center = modules-center;
            modules-right = ["custom/notification" "pulseaudio" "tray" "battery" "clock" "custom/powermenu"];
            "sway/workspaces" = commonWorkspaces;
            "niri/workspaces" = commonWorkspaces;
            "wlr/workspaces" = {
              format = "<span font='11'>{name}</span>";
              active-only = false;
              on-click = "activate";
            };
            "hyprland/workspaces" = {
              format = "{name}";
              format-icons = {
                default = " ";
                active = " ";
                urgent = " ";
              };
              # active-only = false;
              # on-click = "activate";
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
              spacing = 12;
            };

            "clock" = {
              tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
              format = "󱑏 {:%H:%M}";
              format-alt = " {:%A, %B %d, %Y}";
              tooltip = true;
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
              format = "{icon} {capacity}%";
              tooltip-format = "{timeTo} {capacity}%";
              format-charging = "{capacity}% ";
              format-plugged = " {capacity}%";
              format-alt = "{time} {icon}";
              format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
              on-click = "";
            };

            "network" = {
              format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
              format-ethernet = " {bandwidthDownBits}";
              format-wifi = " {bandwidthDownBits}";
              format-disconnected = "󰤮";
              tooltip = false;
              on-click = "${pkgs.${userSettings.terminal}}/bin/${userSettings.terminal} -e btop";
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
              format-bluetooth = "{volume}% {icon} {format_source}";
              format-bluetooth-muted = " {icon} {format_source}";
              format-source = " {volume}%";
              format-source-muted = "";
              format-muted = " {format_source}";
              format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = ["" "" ""];
              };
              tooltip-format = "{desc} {volume}%";
              on-click = "${pkgs.pamixer}/bin/pamixer -t";
              on-click-right = "${pkgs.pamixer}/bin/pamixer --default-source -t";
              on-click-middle = "${pkgs.pavucontrol}/bin/pavucontrol";
              on-click-middle-release = "sleep 0";
            };

            "custom/notification" = {
              tooltip = false;
              format = "{icon} {}";
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
              on-click = "sleep 0.1; swaync-client -t";
              escape = true;
            };

            "custom/menu" = {
              format = "";
              on-click = "sleep 0.1 && ${pkgs.rofi-wayland}/bin/rofi -show drun";
              tooltip = false;
            };

            "custom/powermenu" = {
              format = "⏻";
              on-click = "sleep 0.1 && ${pkgs.wlogout}/bin/wlogout -b 2 --protocol layer-shell";
              tooltip = false;
            };

            "custom/window_class" = {
              exec = "hypr_window";
              interval = 1;
              format = "{}";
              tooltip = false;
            };

            "hyprland/window" = {
              max-length = 60;
              separate-outputs = false;
            };
          };
        };
        style = ''
          * {
            font-size: 16px;
            font-family: JetBrainsMono Nerd Font Propo, Font Awesome, sans-serif;
            font-weight: bold;
          }
          window#waybar {
            background-color: rgba(26,27,38,0);
            border-bottom: 1px solid rgba(26,27,38,0);
            border-radius: 0px;
            color: #${config.lib.stylix.colors.base0F};
          }
          #workspaces {
            background: linear-gradient(45deg, #${config.lib.stylix.colors.base01}, #${config.lib.stylix.colors.base01});
            margin: 5px;
            padding: 0px 1px;
            border-radius: 15px;
            border: 0px;
            font-style: normal;
            color: #${config.lib.stylix.colors.base00};
          }
          #workspaces button {
            padding: 0px 5px;
            margin: 4px 3px;
            border-radius: 15px;
            border: 0px;
            color: #${config.lib.stylix.colors.base00};
            background: linear-gradient(45deg, #${config.lib.stylix.colors.base0D}, #${config.lib.stylix.colors.base0E});
            opacity: 0.5;
            transition: all 0.3s ease-in-out;
          }
          #workspaces button.active {
            padding: 0px 5px;
            margin: 4px 3px;
            border-radius: 15px;
            border: 0px;
            color: #${config.lib.stylix.colors.base00};
            background: linear-gradient(45deg, #${config.lib.stylix.colors.base0D}, #${config.lib.stylix.colors.base0E});
            opacity: 1.0;
            min-width: 40px;
            transition: all 0.3s ease-in-out;
          }
          #workspaces button:hover {
            border-radius: 15px;
            color: #${config.lib.stylix.colors.base00};
            background: linear-gradient(45deg, #${config.lib.stylix.colors.base0D}, #${config.lib.stylix.colors.base0E});
            opacity: 0.8;
          }
          tooltip {
            background: #${config.lib.stylix.colors.base00};
            border: 1px solid #${config.lib.stylix.colors.base0E};
            border-radius: 10px;
          }
          tooltip label {
            color: #${config.lib.stylix.colors.base07};
          }
          #window, #custom-window_class {
            margin: 5px;
            padding: 2px 20px;
            color: #${config.lib.stylix.colors.base05};
            background: #${config.lib.stylix.colors.base01};
            border-radius: 15px;
          }
          #memory {
            color: #${config.lib.stylix.colors.base0F};
            background: #${config.lib.stylix.colors.base01};
            margin: 5px;
            padding: 2px 20px;
            border-radius: 15px;
          }
          #clock {
            color: #${config.lib.stylix.colors.base0B};
            background: #${config.lib.stylix.colors.base00};
            border-radius: 15px;
            margin: 5px;
            padding: 2px 20px;
          }
          #idle_inhibitor {
            color: #${config.lib.stylix.colors.base09};
            background: #${config.lib.stylix.colors.base00};
            border-radius: 15px;
            margin: 5px;
            padding: 2px 20px;
          }
          #cpu {
            color: #${config.lib.stylix.colors.base07};
            background: #${config.lib.stylix.colors.base00};
            border-radius: 15px;
            margin: 5px;
            padding: 2px 20px;
          }
          #disk {
            color: #${config.lib.stylix.colors.base0F};
            background: #${config.lib.stylix.colors.base00};
            border-radius: 15px;
            margin: 5px;
            padding: 2px 20px;
          }
          #battery {
            color: #${config.lib.stylix.colors.base08};
            background: #${config.lib.stylix.colors.base00};
            border-radius: 15px;
            margin: 5px;
            padding: 2px 20px;
          }
          #network {
            color: #${config.lib.stylix.colors.base09};
            background: #${config.lib.stylix.colors.base00};
            border-radius: 15px;
            margin: 5px;
            padding: 2px 20px;
          }
          #tray {
            color: #${config.lib.stylix.colors.base05};
            background: #${config.lib.stylix.colors.base00};
            border-radius: 15px;
            margin: 5px;
            padding: 2px 15px;
          }
          #pulseaudio {
            color: #${config.lib.stylix.colors.base0D};
            background: #${config.lib.stylix.colors.base01};
            margin: 4px;
            padding: 2px 20px;
            border-radius: 15px;
          }
          #custom-notification {
            color: #${config.lib.stylix.colors.base0C};
            background: #${config.lib.stylix.colors.base00};
            border-radius: 15px;
            margin: 5px;
            padding: 2px 20px;
          }
          #custom-menu {
            color: #${config.lib.stylix.colors.base0E};
            background: #${config.lib.stylix.colors.base00};
            border-radius: 0px 15px 15px 0px;
            margin: 5px 5px 5px 0px;
            padding: 2px 20px;
          }
          #custom-powermenu {
            color: #${config.lib.stylix.colors.base0E};
            background: #${config.lib.stylix.colors.base00};
            border-radius: 15px 0px 0px 15px;
            margin: 5px 0px 5px 5px;
            padding: 2px 20px;
          }
        '';
      };
    };
  };
}
