{
  pkgs,
  config,
  lib,
  userSettings,
  ...
}: let
  colors = import ../../theming/colors.nix;
  modules-left = with config;
    if hyprland.enable == true
    then [
      "hyprland/workspaces"
      "hyprland/window"
    ]
    else if sway.enable == true
    then [
      "sway/workspaces"
      "sway/window"
    ]
    else if niri.enable == true
    then [
      "niri/workspaces"
      "niri/window"
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
  config = lib.mkIf (config.wlwm.enable && userSettings.style == "waybar-oglo") {
    home-manager.users.${userSettings.username} = with colors.scheme.${userSettings.theme}; {
      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 30;
            spacing = 4;
            modules-left = modules-left;
            modules-right = ["idle_inhibitor" "custom/notification" "custom/menu" "pulseaudio" "battery" "clock" "tray" "custom/powermenu"];
            "sway/workspaces" = commonWorkspaces;
            "niri/workspaces" = commonWorkspaces;
            "wlr/workspaces" = {
              format = "<span font='11'>{name}</span>";
              active-only = false;
              on-click = "activate";
            };
            "hyprland/workspaces" = {
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
              format = " ";
              # on-click = "${pkgs.rofi-wayland}/bin/rofi -show drun";
              # on-click = "${pkgs.eww}/bin/eww open --toggle bar-menu --screen 0";
              on-click = "${pkgs.eww}/bin/eww open --toggle bar-menu";
              # on-click-release = "sleep 0";
              tooltip = false;
            };

            "custom/powermenu" = {
              format = "⏻ ";
              # on-click = "${pkgs.wlogout}/bin/wlogout -b 2 --protocol layer-shell";
              on-click = "${pkgs.eww}/bin/eww open --toggle powermenu-window";
              # on-click-release = "sleep 1";
              tooltip = false;
            };
          };
        };
        style = ''

          * {
              font-family: JetBrainsMono Nerd Font Propo, FontAwesome, Roboto, Helvetica, Arial, sans-serif;
              font-size: 14px;
              font-weight: bold;
          }

          window#waybar {
              background-color: #${background2};
              border-bottom: 8px solid #${background2-bottom};
              color: #${foreground};
              transition-property: background-color;
              transition-duration: .5s;
          }

          window#waybar.hidden {
              opacity: 0.2;
          }

          /*
          window#waybar.empty {
              background-color: transparent;
          }
          window#waybar.solo {
              background-color: #FFFFFF;
          }
          */

          button {
              all: unset;
              background-color: #${button};
              color: #${button-foreground};
              border: none;
              border-bottom: 8px solid #${button-bottom};
              border-radius: 5px;
              margin-left: 4px;
              margin-bottom: 2px;
              font-family: JetBrainsMono Nerd Font, sans-sherif;
              font-weight: bold;
              font-size: 14px;
              padding-left: 15px;
              padding-right: 15px;
              transition: transform 0.1s ease-in-out;
          }

          button:hover {
              background: inherit;
              background-color: #${button-hover};
              border-bottom: 8px solid #${button-bottom-hover};
          }

          button.active {
              background: inherit;
              background-color: #${button-active};
              border-bottom: 8px solid #${button-bottom-active};
          }

          #mode {
              background-color: #64727D;
              border-bottom: 3px solid #ffffff;
          }

          #clock,
          #battery,
          #cpu,
          #memory,
          #disk,
          #temperature,
          #backlight,
          #bluetooth,
          #network,
          #pulseaudio,
          #wireplumber,
          #custom-media,
          #tray,
          #mode,
          #idle_inhibitor,
          #scratchpad,
          #custom-notification,
          #custom-menu,
          #mpd {
              padding: 0 10px;
              color: #ffffff;
          }

          #window,
          #workspaces {
              margin: 0 4px;
          }

          /* If workspaces is the leftmost module, omit left margin */
          .modules-left > widget:first-child > #workspaces {
              margin-left: 0;
          }

          /* If workspaces is the rightmost module, omit right margin */
          .modules-right > widget:last-child > #workspaces {
              margin-right: 0;
          }

          #window {
              background-color: #${background3};
              color: #${foreground};
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid #${background3-bottom};
              border-radius: 5px;
              margin-bottom: 2px;
              padding-left: 10px;
              padding-right: 10px;
          }

          #custom-notification {
              background-color: #${button};
              color: #${button-foreground};
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 18px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid #${button-bottom};
              border-radius: 5px;
              margin-bottom: 2px;
              padding-left: 13px;
              padding-right: 9px;
          }

          #custom-menu {
              background-color: #${button};
              color: #${button-foreground};
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 18px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid #${button-bottom};
              border-radius: 5px;
              margin-bottom: 2px;
              padding-left: 14px;
              padding-right: 8px;
          }

          #custom-powermenu {
              background-color: #${powermenu-button};
              color: #${powermenu-button-foreground};
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 22px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid #${powermenu-button-bottom};
              border-radius: 5px;
              margin-bottom: 2px;
              margin-right: 4px;
              padding-left: 14px;
              padding-right: 7px;
          }

          #clock {
              background-color: #${waybar-clock};
              color: #${waybar-module-foreground};
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid #${waybar-clock-bottom};
              border-radius: 5px;
              margin-bottom: 2px;
          }

          #battery {
              background-color: #${waybar-battery};
              color: #${waybar-module-foreground};
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid #${waybar-battery-bottom};
              border-radius: 5px;
              margin-bottom: 2px;
          }

          @keyframes blink {
              to {
                  background-color: #ffffff;
                  color: #000000;
              }
          }

          #battery.critical:not(.charging) {
              background-color: #${waybar-battery-critical};
              color: #${waybar-module-foreground};
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid #${waybar-battery-bottom-critical};
              border-radius: 5px;
              margin-bottom: 2px;
          }

          label:focus {
              background-color: #000000;
          }

          #cpu {
              background-color: #${waybar-cpu};
              color: #${waybar-module-foreground};
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid #${waybar-cpu-bottom};
              border-radius: 5px;
              margin-bottom: 2px;
          }

          #memory {
              background-color: #${waybar-memory};
              color: #${waybar-module-foreground};
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid #${waybar-memory-bottom};
              border-radius: 5px;
              margin-bottom: 2px;
          }

          #disk {
              background-color: #964B00;
          }

          #backlight {
              background-color: #${waybar-backlight};
              color: #${waybar-module-foreground};
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid #${waybar-backlight-bottom};
              border-radius: 5px;
              margin-bottom: 2px;
          }

          #network {
              background-color: #2980b9;
          }

          #network.disconnected {
              background-color: #f53c3c;
          }

          #bluetooth {
              background-color: #2980b9;
          }

          #bluetooth.disconnected {
              background-color: #f53c3c;
          }

          #pulseaudio {
              background-color: #${waybar-pulseaudio};
              color: #${waybar-module-foreground};
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid #${waybar-pulseaudio-bottom};
              border-radius: 5px;
              margin-bottom: 2px;
          }

          /*
          #pulseaudio.muted {
              background-color: #90b1b1;
              color: #2a5c45;
          }
          */

          #wireplumber {
              background-color: #fff0f5;
              color: #000000;
          }

          #wireplumber.muted {
              background-color: #f53c3c;
          }

          #custom-media {
              background-color: #66cc99;
              color: #2a5c45;
              min-width: 100px;
          }

          #custom-media.custom-spotify {
              background-color: #66cc99;
          }

          #custom-media.custom-vlc {
              background-color: #ffa000;
          }

          #temperature {
              background-color: #f0932b;
          }

          #temperature.critical {
              background-color: #eb4d4b;
          }

          #tray {
              background-color: #${waybar-tray};
              color: #${waybar-module-foreground};
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid #${waybar-tray-bottom};
              border-radius: 5px;
              margin-bottom: 2px;
          }

          #tray > .passive {
              -gtk-icon-effect: dim;
          }

          #tray > .needs-attention {
              -gtk-icon-effect: highlight;
              background-color: #eb4d4b;
          }

          #idle_inhibitor {
              background-color: #${waybar-battery};
              color: #${waybar-module-foreground};
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid #${waybar-battery-bottom};
              border-radius: 5px;
              margin-bottom: 2px;
              padding-left: 13px;
              padding-right: 16px;
          }

          #idle_inhibitor.activated {
              background-color: #${powermenu-button};
              color: #${powermenu-button-foreground};
              border-bottom: 8px solid #${powermenu-button-bottom};
          }

          #mpd {
              background-color: #66cc99;
              color: #2a5c45;
          }

          #mpd.disconnected {
              background-color: #f53c3c;
          }

          #mpd.stopped {
              background-color: #90b1b1;
          }

          #mpd.paused {
              background-color: #51a37a;
          }

          #language {
              background: #00b093;
              color: #740864;
              padding: 0 5px;
              margin: 0 5px;
              min-width: 16px;
          }

          #keyboard-state {
              background: #97e1ad;
              color: #000000;
              padding: 0 0px;
              margin: 0 5px;
              min-width: 16px;
          }

          #keyboard-state > label {
              padding: 0 5px;
          }

          #keyboard-state > label.locked {
              background: rgba(0, 0, 0, 0.2);
          }

          #scratchpad {
              background: rgba(0, 0, 0, 0.2);
          }

          #scratchpad.empty {
            background-color: transparent;
          }

          tooltip {
            background-color: #${background2};
            border: none;
            border-bottom: 8px solid #${background2-bottom};
            border-radius: 5px;
          }

          tooltip decoration {
            box-shadow: none;
          }

          tooltip decoration:backdrop {
            box-shadow: none;
          }

          tooltip label {
            color: #${foreground};
            font-family: JetBrainsMono Nerd Font, monospace;
            font-size: 16px;
            padding-left: 5px;
            padding-right: 5px;
            padding-top: 0px;
            padding-bottom: 5px;
          }
        '';
      };
    };
  };
}
