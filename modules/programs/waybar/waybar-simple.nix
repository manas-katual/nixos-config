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
      "custom/separator"
      "custom/menu"
      "hyprland/workspaces"
    ]
    else if sway.enable == true
    then [
      "custom/separator"
      "custom/menu"
      "sway/workspaces"
    ]
    else if niri.enable == true
    then [
      "custom/separator"
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
  config = lib.mkIf (config.wlwm.enable && userSettings.style == "waybar-simple") {
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
            modules-center = ["custom/window_class" "custom/notification" "idle_inhibitor"];
            modules-right =
              if config.sway.enable
              then ["tray" "backlight" "network" "bluetooth" "clock" "battery" "custom/powermenu"]
              else ["pulseaudio#icon" "pulseaudio#text" "clock#icon" "clock#text" "tray" "custom/separator"];
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

            "clock#icon" = {
              format = "󱑏";
              tooltip = false;
            };
          };
          "clock#text" = {
            format = "{:%I:%M %p}";
            format-alt = "{:%a:%d %b}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "month";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                months = "<span color='#ffead3'><b>{}</b></span>";
                days = "<span color='#ecc6d9'>{}</span>";
                weeks = "<span color='#99ffdd'><b>W{}</b></span>";
                weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                today = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
            };
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

          "battery#icon" = {
            interval = 3;
            states = {
              warning = "30";
              critical = "15";
            };
            format = "{icon}";
            tooltip-format = "{timeTo} {capacity}%";
            format-charging = "{capacity}% ";
            format-plugged = " ";
            format-alt = "{time} {icon}";
            format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };
          "battery#text" = {
            interval = 3;
            signal = 3;
            states = {
              warning = "30";
              critical = "15";
            };
            format = "{capacity}%";
            tooltip-format = "Battery: {capacity}%\nTime remaining: {time}";
            format-charging = "{capacity}%";
            format-plugged = " ";
            format-alt = "{time} {icon}";
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

          "pulseaudio#icon" = {
            format = "{icon}";
            format-muted = "";
            format-bluetooth = "{icon} {volume}%";
            format-bluetooth-muted = "  {volume}%";
            format-source = "";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["" "" ""];
            };
            on-click = "${pkgs.pamixer}/bin/pamixer --default-source -t";
            on-click-middle = "${pkgs.pavucontrol}/bin/pavucontrol";
            on-click-middle-release = "sleep 0";
            tooltip = false;
          };
          "pulseaudio#text" = {
            format = "{volume}%";
            format-muted = "{volume}%";
            on-click = "${pkgs.pamixer}/bin/pamixer -t";
            on-click-right = "${pkgs.pamixer}/bin/pamixer --default-source -t";
            on-click-middle = "${pkgs.pavucontrol}/bin/pavucontrol";
            on-click-middle-release = "sleep 0";
            tooltip = true;
            tooltip-format = "Volume: {volume}%\nDevice: {desc}";
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

          "custom/separator" = {
            format = "  ";
            tooltip = false;
          };
        };
        style = lib.concatStrings (
          [
            ''

              * {
                font-family:
                  "JetBrainsMono Nerd Font Mono",
                  "Cantarell",
                  "Noto Sans CJK JP",
                  "Nerd Font",
                  sans-serif;
                font-size: 14px;
                font-weight: 500;
              }

              #waybar {
                background: transparent;
                color: #${config.lib.stylix.colors.base05};
                border-radius: 50px;
                background-color: rgba(0, 0, 0, 0.3);
              }

              tooltip {
                background-color: #${config.lib.stylix.colors.base00};
                border: 1px solid #${config.lib.stylix.colors.base0D};
                border-radius: 8px;
              }

              tooltip label {
                color: #${config.lib.stylix.colors.base05};
              }

              button {
                border: none;
                border-radius: 0;
                padding: 0 5px;
                transition: all 0.2s ease;
              }

              #workspaces {
                background-color: #${config.lib.stylix.colors.base00};
                border-radius: 10px;
                margin: 5px;
                padding: 2px;
              }

              #workspaces button {
                background-color: transparent;
                color: #${config.lib.stylix.colors.base04};
                border-radius: 6px;
                margin: 0 2px;
                padding: 0 8px;
                transition: all 0.2s ease;
              }

              #workspaces button:hover {
                color: #${config.lib.stylix.colors.base0E};
                background-color: rgba(187, 154, 247, 0.1);
              }

              #workspaces button.active {
                color: #${config.lib.stylix.colors.base0D};
                background-color: rgba(122, 162, 247, 0.1);
                font-weight: bold;
              }

              #workspaces button.urgent {
                background-color: #${config.lib.stylix.colors.base08};
                color: #${config.lib.stylix.colors.base00};
              }

              #custom-separator {
                margin-right: 10px;
                margin-left: 10px;
              }

              #custom-opensuse, #custom-menu {
                /*background-image: url("file:///home/matt/mhome/Pictures/Logos/distros/opensuseblack.svg");*/
                background-color: #${config.lib.stylix.colors.base0B};
                background-repeat: no-repeat;
                background-position: center;
                background-size: 29px;
                padding: 0px 3px;
                margin: 5px;
                border-radius: 10px;
                min-width: 24px;
                min-height: 24px;
              }

              #custom-notification {
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base0A};
                padding: 0 12px;
                border-radius: 10px;
                margin: 5px;
                font-size: 20px;
              }

              #window, #custom-window_class {
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base0B};
                padding: 0 12px;
                border-radius: 10px;
                margin: 5px;
              }

              #custom-updates.icon {
                background-color: #${config.lib.stylix.colors.base0A};
                color: #${config.lib.stylix.colors.base00};
                padding: 0 7px;
                border-radius: 10px 0 0 10px;
                margin: 5px 0 5px 5px;
                font-size: 20px;
              }

              #custom-updates.text {
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base0A};
                padding: 0 12px;
                border-radius: 0 10px 10px 0;
                margin: 5px 5px 5px 0;
              }

              #idle_inhibitor {
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base05};
                border-radius: 10px;
                margin: 5px;
                padding: 0 10px;
                font-size: 20px;
              }

              #idle_inhibitor.activated {
                color: #${config.lib.stylix.colors.base0B};
              }

              #network.icon {
                background-color: #${config.lib.stylix.colors.base0E};
                color: #${config.lib.stylix.colors.base00};
                padding: 0 12px;
                border-radius: 10px 0 0 10px;
                margin: 5px 0 5px 5px;
              }

              #network.text {
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base0E};
                padding: 0 12px;
                border-radius: 0 10px 10px 0;
                margin: 5px 5px 5px 0;
              }

              #bluetooth.icon {
                background-color: #${config.lib.stylix.colors.base0C};
                color: #${config.lib.stylix.colors.base00};
                padding: 0 12px;
                border-radius: 10px;
                margin: 5px;
              }

              #cpu.icon {
                background-color: #${config.lib.stylix.colors.base0D};
                color: #${config.lib.stylix.colors.base00};
                padding: 0px 13px 0px 5px;
                border-radius: 10px 0 0 10px;
                margin: 5px;
                font-size: 15px;
              }

              #cpu.text {
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base0B};
                padding: 0 12px;
                border-radius: 0 10px 10px 0;
                margin: 5px 5px 5px 0;
              }

              #memory.icon {
                background-color: #${config.lib.stylix.colors.base0C};
                color: #${config.lib.stylix.colors.base00};
                padding: 0px 5px 0px 6px;
                border-radius: 10px 0 0 10px;
                margin: 5px 0 5px 5px;
                font-size: 20px;
              }

              #memory {
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base0C};
                padding: 0 12px;
                border-radius: 0 10px 10px 0;
                margin: 5px 5px 5px 0;
              }

              #battery.icon {
                background-color: #${config.lib.stylix.colors.base09};
                color: #${config.lib.stylix.colors.base00};
                padding: 0 12px;
                border-radius: 10px 0 0 10px;
                margin: 5px 0 5px 5px;
              }

              #battery.text {
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base09};
                padding: 0 12px;
                border-radius: 0 10px 10px 0;
                margin: 5px 5px 5px 0;
              }

              #battery.critical:not(.charging) {
                animation: blink 0.7s cubic-bezier(0.68, -0.55, 0.27, 1.55) infinite alternate;
              }

              #pulseaudio.icon {
                background-color: #${config.lib.stylix.colors.base0D};
                color: #${config.lib.stylix.colors.base00};
                padding: 0px 5px 0px 6px;
                border-radius: 10px 0 0 10px;
                margin: 5px 0px 5px 0px;
                font-size: 20px;
              }

              #pulseaudio.text {
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base0D};
                padding: 0 12px;
                border-radius: 0 10px 10px 0;
                margin: 5px 5px 5px 0;
              }

              #clock.icon {
                background-color: #${config.lib.stylix.colors.base08};
                color: #${config.lib.stylix.colors.base00};
                padding: 0px 5px 0px 6px;
                border-radius: 10px 0 0 10px;
                margin: 5px 0px 5px 0px;
                font-size: 20px;
              }

              #clock.text {
                background-color: #${config.lib.stylix.colors.base00};
                color: #${config.lib.stylix.colors.base08};
                padding: 0 12px;
                border-radius: 0 10px 10px 0;
                margin: 5px 5px 5px 0;
              }

              #tray {
                background-color: #${config.lib.stylix.colors.base00};
                padding: 0 10px;
                border-radius: 10px;
                margin: 5px;
              }

              #tray > .passive {
                -gtk-icon-effect: dim;
              }

              #tray > .needs-attention {
                -gtk-icon-effect: highlight;
                background-color: #${config.lib.stylix.colors.base08};
              }

              @keyframes blink {
                to {
                  background-color: #${config.lib.stylix.colors.base08};
                  color: #${config.lib.stylix.colors.base00};
                }
              }

              .modules-left > widget\:first-child > #workspaces {
                margin-left: 0;
              }

              .modules-right > widget\:last-child > #workspaces {
                margin-right: 0;
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
