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
      "custom/window_class"
      "idle_inhibitor"
    ]
    else if sway.enable == true
    then [
      "sway/workspaces"
      "custom/window_class"
      "idle_inhibitor"
    ]
    else if niri.enable == true
    then [
      "niri/workspaces"
      "custom/window_class"
      "idle_inhibitor"
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
  config = lib.mkIf (config.wlwm.enable && userSettings.style == "waybar-dwm") {
    home-manager.users.${userSettings.username} = {
      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 30;
            spacing = 4;
            modules-left = modules-left;
            modules-center = ["custom/spacer"];
            modules-right =
              if config.sway.enable
              then ["tray" "backlight" "network" "bluetooth" "clock" "battery" "custom/powermenu"]
              else if config.hyprland.enable
              then ["custom/notification" "clock" "battery" "tray" "custom/powermenu"]
              else [];
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
              format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
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

            "custom/notification" = lib.mkIf config.hyprland.enable {
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

            "custom/window_class" = {
              exec =
                if config.hyprland.enable
                then "hypr_window"
                else if config.sway.enable
                then "sway_window"
                else "";
              interval = 1;
              format = "{}";
              tooltip = false;
            };
          };
        };
        style = lib.concatStrings (
          [
            ''
              * {
                min-height: 0;
                margin: 0;
                padding: 0;
                border-radius: 7px;
                font-family: JetBrains Mono Nerd Font Propo;
                font-size: 10pt;
                font-weight: 700;
                padding-bottom: 0px;
              }

              tooltip {
                background: #${config.lib.stylix.colors.base00};
                border-radius: 7px;
                border: 2px solid #${config.lib.stylix.colors.base02};
              }

              #window, #custom-window_class {
                margin: 0;
                padding-left: 10px;
                padding-right: 7px;
                border-radius: 3px;
                border-color: #${config.lib.stylix.colors.base01};
                background-color: #${config.lib.stylix.colors.base0A};
                color: #${config.lib.stylix.colors.base00};
              }

              window#waybar.empty #window {
                background-color: #${config.lib.stylix.colors.base00};
                border-bottom: none;
                border-right: none;
              }

              window#waybar {
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base0C};
              }

              /* Workspaces */
              @keyframes button_activate {
                from { opacity: 0.3; }
                to { opacity: 1; }
              }

              #workspaces {
                margin: 0;
                border-radius: 3px;
                padding: 1px;
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base00};
              }

              #workspaces button {
                margin: 0;
                border-radius: 3px;
                padding-left: 3px;
                padding-right: 9px;
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base05};
              }


              #workspaces button.urgent {
                color: #${config.lib.stylix.colors.base08};
              }

              #workspaces button:hover {
                border: solid transparent;
              }

              #custom-gpu-util {
                margin: 0;
                padding-left: 10px;
                padding-right: 10px;
                border-radius: 7px;
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base05};
              }

              #tray {
                margin: 0;
                border-radius: 3px;
                padding-left: 10px;
                padding-right: 10px;
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base05};
              }

              #idle_inhibitor,
              #custom-notification {
                margin: 0;
                padding-left: 10px;
                padding-right: 12px;
                border-radius: 3px;
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base05};
              }

              #network {
                margin: 5px 5px 2px 5px;
                padding-left: 10px;
                padding-right: 12px;
                border-radius: 7px;
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base0C};
              }

              #network.linked {
                color: #${config.lib.stylix.colors.base09};
              }
              #network.disconnected,
              #network.disabled {
                color: #${config.lib.stylix.colors.base08};
              }

              #custom-subs {
                color: #${config.lib.stylix.colors.base05};
                margin: 5px 5px 2px 5px;
                padding-left: 10px;
                padding-right: 12px;
                border-radius: 3px;
                border-bottom: 2px solid #${config.lib.stylix.colors.base00};
                border-right: 2px solid #${config.lib.stylix.colors.base00};
                border-color: #${config.lib.stylix.colors.base01};
                background-color: #${config.lib.stylix.colors.base08};
              }

              #custom-spacer {
                background-color: #${config.lib.stylix.colors.base0A};
              }

              #custom-cliphist {
                color: #${config.lib.stylix.colors.base09};
                margin: 5px 5px 2px 5px;
                padding-left: 10px;
                padding-right: 12px;
                border-radius: 3px;
                background-color: #${config.lib.stylix.colors.base00};
              }

              #custom-gpu-temp,
              #cpu,
              #memory,
              #custom-clipboard,
              #temperature,
              #custom-powermenu{
                margin: 0;
                padding-left: 10px;
                padding-right: 10px;
                border-radius: 3px;
                color: #${config.lib.stylix.colors.base05};
                background-color: #${config.lib.stylix.colors.base00};
              }

              #custom-playerctl {
                margin: 5px 5px 2px 5px;
                padding-left: 10px;
                padding-right: 10px;
                border-radius: 3px;
                color: #${config.lib.stylix.colors.base05};
                background-color: #${config.lib.stylix.colors.base00};
              }

              #battery,
              #backlight,
              #bluetooth,
              #pulseaudio {
                margin-top: 5px;
                margin-bottom: 2px;
                color: #${config.lib.stylix.colors.base05};
                background-color: #${config.lib.stylix.colors.base00};
                border-top-right-radius: 0px;
                border-bottom-right-radius: 0px;
                border-top-left-radius: 3px;
                border-bottom-left-radius: 3px;
              }

              #battery,
              #bluetooth {
                margin-left: 0;
                margin-right: 5px;
                padding-left: 7.5px;
                padding-right: 10px;
                border-top-left-radius: 0px;
                border-bottom-left-radius: 0px;
                border-top-right-radius: 3px;
                border-bottom-right-radius: 3px;
              }

              #backlight,
              #pulseaudio {
                margin-right: 0;
                margin-left: 5px;
                padding-left: 10px;
                padding-right: 7.5px;
                border-top-right-radius: 0px;
                border-bottom-right-radius: 0px;
                border-top-left-radius: 3px;
                border-bottom-left-radius: 3px;
              }

              #clock {
                margin: 0;
                padding-left: 10px;
                padding-right: 10px;
                border-radius: 3px;
                color: #${config.lib.stylix.colors.base00};
                background-color: #${config.lib.stylix.colors.base0B};
              }

              #taskbar {
                border-radius: 0px;
                padding: 0 3px;
                margin: 0;
                color: #ffffff;
                background-color: rgba(120, 118, 117, 0.3);
              }

              #taskbar button {
                border-radius: 0px;
                padding: 0 0 0 3px;
                margin: 3px 1;
                color: #ffffff;
                background-color: rgba(120, 118, 117, 0.1);
              }

              #taskbar button.active {
                background-color: rgba(120, 118, 117, 0.8);
              }

              #mode {
                margin: 0;
                padding-left: 10px;
                padding-right: 10px;
                border-radius: 3px;
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base09};
              }
            ''
          ]
          ++ (
            if config.sway.enable
            then [
              ''
                #workspaces button.focused {
                  background-color: #${config.lib.stylix.colors.base0D};
                  color: #${config.lib.stylix.colors.base00};
                }
              ''
            ]
            else [
              ''
                #workspaces button.active {
                  background-color: #${config.lib.stylix.colors.base0D};
                  color: #${config.lib.stylix.colors.base00};
                }
              ''
            ]
          )
        );
      };
    };
  };
}
