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
      "custom/menu"
      "hyprland/workspaces"
    ]
    else if sway.enable == true
    then [
      "custom/menu"
      "sway/workspaces"
    ]
    else if niri.enable == true
    then [
      "custom/menu"
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
  config = lib.mkIf (config.wlwm.enable && userSettings.style == "waybar-macos") {
    home-manager.users.${userSettings.username} = {
      programs.waybar = {
        enable = true;
        package = pkgs.waybar;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 30;
            spacing = 4;
            modules-center = ["custom/window_class" "custom/notification"];
            modules-left = modules-left;
            modules-right = ["idle_inhibitor" "pulseaudio" "clock" "battery" "tray" "custom/powermenu"];
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
              spacing = 12;
            };

            "clock" = {
              tooltip-format = "<tt><small>{calendar}</small></tt>";
              format = "󱑏 {:%H:%M}";
              format-alt = " {:%A, %B %d, %Y}";
              tooltip = true;
            };

            battery = {
              format = "{icon} {capacity}%";
              format-discharging = "{icon} {capacity}%";
              format-charging = "{icon} {capacity}%";
              format-plugged = " {capacity}%";
              format-icons = {
                charging = [
                  "󰢜"
                  "󰂆"
                  "󰂇"
                  "󰂈"
                  "󰢝"
                  "󰂉"
                  "󰢞"
                  "󰂊"
                  "󰂋"
                  "󰂅"
                ];
                default = [
                  "󰁺"
                  "󰁻"
                  "󰁼"
                  "󰁽"
                  "󰁾"
                  "󰁿"
                  "󰂀"
                  "󰂁"
                  "󰂂"
                  "󰁹"
                ];
              };
              format-full = "󰂅";
              tooltip-format-discharging = "{timeTo} {capacity}%";
              tooltip-format-charging = "{timeTo} {capacity}%";
              interval = 3;
              states = {
                warning = 20;
                critical = 10;
              };
            };

            "pulseaudio" = {
              format = "{icon}";
              format-bluetooth = "󱡏 {format_source}";
              format-bluetooth-muted = "󱡐 {format_source}";
              format-source = " {volume}%";
              format-source-muted = "";
              format-muted = "";
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
              on-click = "${pkgs.avizo}/bin/volumectl toggle-mute";
              on-click-right = "${pkgs.avizo}/bin/volumectl -m toggle-mute";
              on-click-middle = "${pkgs.pavucontrol}/bin/pavucontrol";
              on-click-middle-release = "sleep 0";
              on-scroll-up = "${pkgs.avizo}/bin/volumectl -u up";
              on-scroll-down = "${pkgs.avizo}/bin/volumectl -u down";
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
              format = "";
              on-click = "sleep 0.1 && ${pkgs.rofi-wayland}/bin/rofi -show drun";
              tooltip = false;
            };

            "custom/powermenu" = {
              format = "";
              on-click = "sleep 0.1 && ${pkgs.wlogout}/bin/wlogout -b 2 --protocol layer-shell";
              tooltip = false;
            };

            "custom/window_class" = {
              exec = "hypr_window";
              interval = 1;
              signal = 1;
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
            font-family: JetBrainsMono Nerd Font Propo, Font Awesome, sans-serif, SF Pro Display;
            font-size: 18px;
            font-weight: bold;
            color: #${config.lib.stylix.colors.base05};
            /*background: transparent;*/
          }

          window#waybar {
            /*background: transparent;*/
            background-color: rgba(28, 28, 30, 0);
            border-bottom: none;
            margin: 0;
            padding: 5px 10px;
          }

          #waybar > * {
            margin: 0 5px;
          }

          #custom-menu {
            font-size: 20px;
            padding: 0 10px 0 5px;
            color: #${config.lib.stylix.colors.base0E};
          }

          #custom-window_class, #window {
            font-weight: 500;
            font-size: 16px;
            color: #${config.lib.stylix.colors.base0C};
            padding: 0 10px;
          }

          #workspaces {
            background-color: rgba(255, 255, 255, 0.03);
            border-radius: 10px;
            margin: 0 4px;
            padding: 0 6px;
          }

          #workspaces button {
            background: transparent;
            color: #${config.lib.stylix.colors.base05};
            border: none;
            margin: 3px 4px;
            padding: 2px 8px;
            border-radius: 8px;
            font-weight: 500;
            transition: background 0.2s ease;
          }

          #workspaces button.active {
            background-color: rgba(255, 255, 255, 0.08);
            color: #${config.lib.stylix.colors.base0A};
          }

          #workspaces button:hover {
            background-color: rgba(255, 255, 255, 0.05);
          }

          #custom-notification,
          #idle_inhibitor,
          #pulseaudio,
          #battery,
          #clock,
          #tray {
            padding: 0 10px;
            margin: 0 4px;
            border-radius: 10px;
            background-color: rgba(255, 255, 255, 0.03);
            transition: background 0.2s ease;
          }

          #tray {
            padding: 0 8px;
          }

          tooltip {
            background: rgba(30, 30, 32, 0.95);
            border-radius: 8px;
            border: 1px solid #${config.lib.stylix.colors.base03};
            padding: 5px 10px;
          }

          tooltip label {
            color: #${config.lib.stylix.colors.base07};
          }

          #custom-powermenu {
            padding: 0 10px;
            margin: 0 4px;
            border-radius: 10px;
            background-color: rgba(255, 255, 255, 0.03);
            transition: background 0.2s ease;
            color: #${config.lib.stylix.colors.base08};
          }

          #custom-notification:hover,
          #idle_inhibitor:hover,
          #pulseaudio:hover,
          #battery:hover,
          #clock:hover,
          #tray:hover,
          #custom-powermenu:hover {
            background-color: rgba(255, 255, 255, 0.08);
          }

          #clock {
            color: #${config.lib.stylix.colors.base0D};
          }

          #battery {
            color: #${config.lib.stylix.colors.base0B};
          }

          #pulseaudio {
            color: #${config.lib.stylix.colors.base0C};
          }

          #idle_inhibitor {
            color: #${config.lib.stylix.colors.base09};
          }

          #custom-notification {
            color: #${config.lib.stylix.colors.base0A};
          }

        '';
      };
    };
  };
}
