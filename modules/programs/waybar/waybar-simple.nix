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
            position = "bottom";
            height = 30;
            spacing = 4;
            modules-left = modules-left;
            modules-center = [];
            modules-right =
              if config.sway.enable
              then ["idle_inhibitor" "clock" "battery" "tray" "custom/powermenu"]
              else ["idle_inhibitor" "clock" "custom/notification" "battery" "tray" "custom/powermenu"];
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
              exec = "window_class";
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

                font-family: JetBrainsMono Nerd Font, Font Awesome, sans-serif;
                font-size: 11pt;
                font-weight: bold;
                border-radius: 0px;
                transition-property: background-color;
                transition-duration: 0s;
              }

              @keyframes blink_red {
                to {
                  background-color: #${config.lib.stylix.colors.base08};
                  color: #${config.lib.stylix.colors.base00};
                }
              }

              .warning,
              .critical,
              .urgent {
                animation-name: blink_red;
                animation-duration: 1s;
                animation-timing-function: linear;
                animation-iteration-count: infinite;
                animation-direction: alternate;
              }

              #window {
                padding-left: 40px;
                padding-right: 30px;
                transition: none;
                background: transparent;
              }

              window#waybar {
                background-color: transparent;
              }

              window > box {
                margin-left: 0px;
                margin-right: 0px;
                margin-top: 0px;
                border-bottom: 2px solid #${config.lib.stylix.colors.base07};
                background-color: #${config.lib.stylix.colors.base01};
              }

              #workspaces {
                padding-left: 0px;
                padding-right: 4px;
              }

              #workspaces button {
                padding-top: 2px;
                padding-bottom: 2px;
                padding-left: 6px;
                padding-right: 6px;
              }


              #workspaces button.urgent {
                color: #${config.lib.stylix.colors.base00};
              }

              #workspaces button:hover {
                background-color: #${config.lib.stylix.colors.base09};
                color: #${config.lib.stylix.colors.base00};
              }

              tooltip {
                background: #${config.lib.stylix.colors.base01};
              }

              tooltip label {
                color: #${config.lib.stylix.colors.base07};
              }

              #custom-launcher {
                padding-left: 8px;
                padding-right: 6px;
                color: #${config.lib.stylix.colors.base06};
              }

              #mode,
              #clock,
              #memory,
              #temperature,
              #cpu,
              #mpd,
              #idle_inhibitor,
              #temperature,
              #backlight,
              #pulseaudio,
              #network,
              #battery,
              #power-profiles-daemon,
              #custom-powermenu,
              #custom-notification,
              #custom-cava-internal {
                padding-left: 10px;
                padding-right: 10px;
              }

              #memory {
                color: #${config.lib.stylix.colors.base0B};
              }

              #cpu {
                color: #${config.lib.stylix.colors.base0E};
              }

              #clock {
                color: #${config.lib.stylix.colors.base05};
              }

              #idle_inhibitor {
                color: #${config.lib.stylix.colors.base0E};
              }

              #temperature {
                color: #${config.lib.stylix.colors.base0D};
              }

              #custom-notification {
                color: #${config.lib.stylix.colors.base0D};
              }

              #backlight {
                color: #${config.lib.stylix.colors.base09};
              }

              #pulseaudio {
                color: #${config.lib.stylix.colors.base0A};
              }

              #network {
                color: #${config.lib.stylix.colors.base0B};
              }

              #network.disconnected {
                color: #${config.lib.stylix.colors.base07};
              }

              #battery.charging,
              #battery.full,
              #battery.discharging {
                color: #${config.lib.stylix.colors.base0A};
              }

              #battery.critical:not(.charging) {
                color: #${config.lib.stylix.colors.base08};
              }

              #power-profiles-daemon {
                padding-right: 15px;
              }

              #power-profiles-daemon.performance {
                color: #${config.lib.stylix.colors.base08};
              }

              #power-profiles-daemon.balanced {
                color: #${config.lib.stylix.colors.base0D};
              }

              #power-profiles-daemon.power-saver {
                color: #${config.lib.stylix.colors.base0B};
              }

              label:focus {
                background-color: #${config.lib.stylix.colors.base00};
              }

              #custom-powermenu {
                color: #${config.lib.stylix.colors.base08};
              }

              #tray {
                padding-right: 8px;
                padding-left: 10px;
              }

              #mpd.paused {
                color: #${config.lib.stylix.colors.base03};
                font-style: italic;
              }

              #mpd.stopped {
                background: transparent;
              }

              #mpd {
                color: #${config.lib.stylix.colors.base05};
              }

              #custom-cava-internal {
                font-family: "Hack Nerd Font";
              }
            ''
          ]
          ++ (
            if config.sway.enable
            then [
              ''
                #workspaces button.focused {
                  background-color: #${config.lib.stylix.colors.base0B};
                  color: #${config.lib.stylix.colors.base00};
                }
              ''
            ]
            else [
              ''
                #workspaces button.active {
                  background-color: #${config.lib.stylix.colors.base0B};
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
