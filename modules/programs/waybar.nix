{
  pkgs,
  config,
  lib,
  userSettings,
  ...
}: let
  colors = import ../theming/colors.nix;
  username = userSettings.username;
  themeColors = colors.scheme.${userSettings.theme};

  # Define common workspace settings
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

  # Dynamically set left modules based on enabled WM
  modules-left = with config;
    if hyprland.enable
    then ["hyprland/workspaces" "hyprland/window"]
    else if sway.enable
    then ["sway/workspaces" "sway/window"]
    else if niri.enable
    then ["niri/workspaces" "niri/window"]
    else [];
in {
  config = lib.mkIf (config.wlwm.enable && userSettings.bar == "waybar") {
    home-manager.users.${username} = {
      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            height = 30;
            spacing = 4;
            modules-left = modules-left;
            modules-right = [
              "idle_inhibitor"
              "custom/notification"
              "custom/menu"
              "pulseaudio"
              "battery"
              "clock"
              "tray"
              "custom/powermenu"
            ];

            # --- Modules Configuration ---
            "sway/workspaces" = commonWorkspaces;
            "niri/workspaces" = commonWorkspaces;
            "hyprland/workspaces" = {
              # format = "<span font='11'>{name}</span>"; # Uncomment if needed
              active-only = false;
              on-click = "activate";
              on-scroll-up = "hyprctl dispatch workspace e-1";
              on-scroll-down = "hyprctl dispatch workspace e+1";
              disable-scroll = "false";
            };
            "wlr/workspaces" = {
              format = "<span font='11'>{name}</span>";
              active-only = false;
              on-click = "activate";
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
              tooltip = false;
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
                warning = 30;
                critical = 15;
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
              device = "intel_backlight"; # This seems incorrect for a bluetooth module. Check if it should be an actual bluetooth device.
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
              format = " ";
              on-click = "sleep 0.1; ${pkgs.eww}/bin/eww open --toggle bar-menu";
              tooltip = false;
            };
            "custom/powermenu" = {
              format = "⏻ ";
              on-click = "sleep 0.1; ${pkgs.eww}/bin/eww open --toggle powermenu-window";
              tooltip = false;
            };
          };
        };
        style = ''
          /* --- Base Styles --- */
          * {
            font-family: JetBrainsMono Nerd Font, FontAwesome, Roboto, Helvetica, Arial, sans-serif;
            font-size: 14px;
            font-weight: bold;
          }

          window#waybar {
            background-color: #${themeColors.background2};
            border-bottom: 8px solid #${themeColors.background2-bottom};
            color: #${themeColors.foreground};
            transition-property: background-color;
            transition-duration: .5s;
          }

          window#waybar.hidden {
            opacity: 0.2;
          }

          button {
            all: unset;
            background-color: #${themeColors.button};
            color: #${themeColors.button-foreground};
            border: none;
            border-bottom: 8px solid #${themeColors.button-bottom};
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
            background-color: #${themeColors.button-hover};
            border-bottom: 8px solid #${themeColors.button-bottom-hover};
          }

          button.active {
            background: inherit;
            background-color: #${themeColors.button-active};
            border-bottom: 8px solid #${themeColors.button-bottom-active};
          }

          /* --- Common Module Styles --- */
          #clock, #battery, #cpu, #memory, #backlight, #pulseaudio, #tray {
            background-color: inherit; /* Set dynamically below */
            color: #${themeColors.waybar-module-foreground};
            font-family: JetBrainsMono Nerd Font, monospace;
            font-size: 15px;
            font-weight: bold;
            border: none;
            border-bottom: 8px solid; /* Set dynamically below */
            border-radius: 5px;
            margin-bottom: 2px;
            padding: 0 10px;
          }

          #window, #workspaces {
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

          /* --- Specific Module Styles --- */
          #window {
            background-color: #${themeColors.background3};
            color: #${themeColors.foreground};
            font-family: JetBrainsMono Nerd Font, monospace;
            font-size: 15px;
            font-weight: bold;
            border: none;
            border-bottom: 8px solid #${themeColors.background3-bottom};
            border-radius: 5px;
            margin-bottom: 2px;
            padding-left: 10px;
            padding-right: 10px;
          }

          #custom-notification, #custom-menu, #idle_inhibitor {
            background-color: #${themeColors.button};
            color: #${themeColors.button-foreground};
            font-family: JetBrainsMono Nerd Font, monospace;
            font-size: 18px; /* Slightly larger for icons */
            font-weight: bold;
            border: none;
            border-bottom: 8px solid #${themeColors.button-bottom};
            border-radius: 5px;
            margin-bottom: 2px;
            padding-left: 13px;
            padding-right: 9px; /* Adjust padding for better icon centering */
          }

          #custom-menu {
            padding-left: 14px;
            padding-right: 8px;
          }

          #idle_inhibitor {
            padding-left: 13px;
            padding-right: 13px;
          }

          #custom-powermenu {
            background-color: #${themeColors.powermenu-button};
            color: #${themeColors.powermenu-button-foreground};
            font-family: JetBrainsMono Nerd Font, monospace;
            font-size: 22px; /* Larger for power icon */
            font-weight: bold;
            border: none;
            border-bottom: 8px solid #${themeColors.powermenu-button-bottom};
            border-radius: 5px;
            margin-bottom: 2px;
            margin-right: 4px;
            padding-left: 14px;
            padding-right: 7px;
          }

          /* Individual Module Colors */
          #clock {
            background-color: #${themeColors.waybar-clock};
            border-bottom-color: #${themeColors.waybar-clock-bottom};
          }
          #battery {
            background-color: #${themeColors.waybar-battery};
            border-bottom-color: #${themeColors.waybar-battery-bottom};
          }
          #battery.critical:not(.charging) {
            background-color: #${themeColors.waybar-battery-critical};
            border-bottom-color: #${themeColors.waybar-battery-bottom-critical};
          }
          #cpu {
            background-color: #${themeColors.waybar-cpu};
            border-bottom-color: #${themeColors.waybar-cpu-bottom};
          }
          #memory {
            background-color: #${themeColors.waybar-memory};
            border-bottom-color: #${themeColors.waybar-memory-bottom};
          }
          #backlight {
            background-color: #${themeColors.waybar-backlight};
            border-bottom-color: #${themeColors.waybar-backlight-bottom};
          }
          #pulseaudio {
            background-color: #${themeColors.waybar-pulseaudio};
            border-bottom-color: #${themeColors.waybar-pulseaudio-bottom};
          }
          #tray {
            background-color: #${themeColors.waybar-tray};
            border-bottom-color: #${themeColors.waybar-tray-bottom};
          }

          #idle_inhibitor.activated {
            background-color: #${themeColors.powermenu-button};
            color: #${themeColors.powermenu-button-foreground};
            border-bottom-color: #${themeColors.powermenu-button-bottom};
          }

          /* --- Tooltip Styles --- */
          tooltip {
            background-color: #${themeColors.background2};
            border: none;
            border-bottom: 8px solid #${themeColors.background2-bottom};
            border-radius: 5px;
          }
          tooltip decoration {
            box-shadow: none;
          }
          tooltip decoration:backdrop {
            box-shadow: none;
          }
          tooltip label {
            color: #${themeColors.foreground};
            font-family: JetBrainsMono Nerd Font, monospace;
            font-size: 16px;
            padding: 0px 5px 5px 5px; /* Top, Right, Bottom, Left */
          }

          /* --- Other Specific Styles (Keep if needed) --- */
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
          /* These modules don't have common styles defined above, so keep their full definitions */
          #mode {
            background-color: #64727D;
            border-bottom: 3px solid #ffffff;
            padding: 0 10px;
            color: #ffffff;
          }
          #disk {
            background-color: #964B00;
            padding: 0 10px;
            color: #ffffff;
          }
          #temperature {
            background-color: #f0932b;
            padding: 0 10px;
            color: #ffffff;
          }
          #temperature.critical {
            background-color: #eb4d4b;
          }
          #tray > .passive {
            -gtk-icon-effect: dim;
          }
          #tray > .needs-attention {
            -gtk-icon-effect: highlight;
            background-color: #eb4d4b;
          }
          #mpd {
            background-color: #66cc99;
            color: #2a5c45;
            padding: 0 10px;
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
            padding: 0 10px;
            color: #ffffff;
          }
          #scratchpad.empty {
            background-color: transparent;
          }
          @keyframes blink {
            to {
              background-color: #ffffff;
              color: #000000;
            }
          }
          label:focus {
            background-color: #000000;
          }
        '';
      };
    };
  };
}
