{ pkgs, config, lib, userSettings, ... }:

let
  colors = import ../theming/colors.nix;
in
{

  config = lib.mkIf (config.wlwm.enable && userSettings.bar == "waybar") {
    environment.systemPackages = with pkgs; [
      waybar
    ];

    home-manager.users.${userSettings.username} = with colors.scheme.gruvbox; {
      programs.waybar = {
        enable = true;
        # style = ''
        #   /* base16 */
        #   @define-color foreground #''+config.lib.stylix.colors.base07+'';
        #   @define-color background #''+config.lib.stylix.colors.base00+'';
        #   @define-color alt_background #''+config.lib.stylix.colors.base01+'';
        #   @define-color accent #''+config.lib.stylix.colors.base0A+'';

        #   @define-color black #''+config.lib.stylix.colors.base01+'';
        #   @define-color red #''+config.lib.stylix.colors.base09+'';
        #   @define-color green #''+config.lib.stylix.colors.base0B+'';
        #   @define-color yellow #''+config.lib.stylix.colors.base0A+'';
        #   @define-color blue #''+config.lib.stylix.colors.base0C+'';
        #   @define-color magenta #''+config.lib.stylix.colors.base0D+'';
        #   @define-color cyan #''+config.lib.stylix.colors.base0A+'';
        #   @define-color white #''+config.lib.stylix.colors.base05+'';

        #   @define-color alt_black #''+config.lib.stylix.colors.base02+'';
        #   @define-color alt_red #''+config.lib.stylix.colors.base08+'';
        #   @define-color alt_green #''+config.lib.stylix.colors.base0B+'';
        #   @define-color alt_yellow #''+config.lib.stylix.colors.base0A+'';
        #   @define-color alt_blue #''+config.lib.stylix.colors.base0C+'';
        #   @define-color alt_magenta #''+config.lib.stylix.colors.base0D+'';
        #   @define-color alt_cyan #''+config.lib.stylix.colors.base0E+'';
        #   @define-color alt_white #''+config.lib.stylix.colors.base07+'';

        #   /* style.css */

        #   * {
        #     border: none;
        #     font-family: JetBrainsMono Nerd Font, sans-serif;
        #     font-size: 14px;
        #   }

        #   window#waybar {
        #     /* background-color: rgba(18, 21, 29, 0.98); */
        #     background-color: @background;
        #     /* background-color: rgba(0, 0, 0, 0); */
        #     border-radius: 6px;
        #     color: @foreground;
        #     opacity: 0.95;
        #     transition-property: background-color;
        #     transition-duration: .5s;
        #     margin-bottom: -7px;
        #   }

        #   window#waybar.hidden {
        #     opacity: 0.2;
        #   }

        #   window#hyprland-window {
        #     background-color: @background;
        #   }

        #   #workspaces,
        #   #mode,
        #   #window,
        #   #cpu,
        #   #memory,
        #   #temperature,
        #   #custom-media,
        #   #custom-powermenu,
        #   #custom-fans,
        #   #custom-wmname,
        #   #clock,
        #   #idle_inhibitor,
        #   #bluetooth,
        #   #language,
        #   #pulseaudio,
        #   #backlight,
        #   #battery,
        #   #network,
        #   #tray,
        #   #custom-notification {
        #     background-color: @alt_background;
        #     padding: 0 10px;
        #     margin: 5px 2px 5px 2px;
        #     border: 1px solid rgba(0, 0, 0, 0);
        #     border-radius: 6px;
        #     background-clip: padding-box;
        #   }

        #   #workspaces button {
        #     background-color: @alt_background;
        #     padding: 0 5px;
        #     min-width: 20px;
        #     color: @foreground;
        #   }

        #   #workspaces button:hover {
        #     background-color: rgba(0, 0, 0, 0)
        #   }

        #   #workspaces button.active {
        #     color: @accent;
        #   }

        #   #workspaces button.urgent {
        #     color: @red;
        #   }

        #   #cpu {
        #     padding: 0 10px;
        #     color: @alt_cyan;
        #   }

        #   #memory {
        #     padding: 0 10px;
        #     color: @alt_cyan;
        #   }

        #   #temperature {
        #     padding: 0 10px;
        #     color: @blue;
        #   }

        #   #temperature.critical {
        #     background-color: @red;
        #     padding: 0 10px;
        #     color: @background;
        #   }

        #   #custom-media {
        #     color: #c678dd;
        #     padding: 0 10px;
        #     color: @background;
        #   }

        #   #custom-fans {
        #     padding: 0 10px;
        #     color: @blue;
        #   }

        #   #bluetooth {
        #     padding: 0 10px;
        #     color: @blue;
        #   }

        #   #clock {
        #     padding: 0 10px;
        #     color: @blue;
        #   }

        #   #idle_inhibitor {
        #     padding: 0 10px;
        #     color: @foreground;
        #   }

        #   #language {
        #     padding: 0 10px;
        #     color: @blue;
        #   }

        #   #pulseaudio {
        #     padding: 0 10px;
        #     color: @yellow;
        #   }

        #   #pulseaudio.muted {
        #     padding: 0 10px;
        #     background-color: @red;
        #     color: @background;
        #   }

        #   #backlight {
        #     padding: 0 10px;
        #     color: @yellow;
        #   }

        #   #battery {
        #     padding: 0 10px;
        #     color: @alt_green;
        #   }

        #   #battery.charging, #battery.plugged {
        #     padding: 0 10px;
        #     background-color: @alt_green;
        #     color: @background;
        #   }

        #   @keyframes blink {
        #     to {
        #       background-color: @background;
        #       color: @red;
        #     }
        #   }

        #   #battery.critical:not(.charging) {
        #     padding: 0 10px;
        #     background-color: @red;
        #     color: @background;
        #     animation-name: blink;
        #     animation-duration: 0.5s;
        #     animation-timing-function: linear;
        #     animation-iteration-count: infinite;
        #     animation-direction: alternate;
        #   }

        #   #network {
        #     padding: 0 10px;
        #     color: @blue;
        #   }

        #   #custom-wmname {
        #     color: @accent;
        #     background-color: @background;
        #     font-size: 25px;
        #     margin: 1px;
        #     padding: 0px 0px 0px 5px;
        #   }

        #   #network.disconnected {
        #     padding: 0 10px;
        #     background-color: @red;
        #     color: @background;
        #   }
        #   #custom-powermenu {
        #     background-color: @red;
        #     color: @background;
        #     font-size: 15px;
        #     padding-right: 6px;
        #     padding-left: 11px;
        #     margin: 5px;
        #   }

        #   #custom-notification {
        #     padding: 0 10px;
        #     color: @accent;
        #   }
        # '';
        #
        #
        style = ''
          @define-color foreground #${foreground};
          @define-color foreground-disabled #282828;
          @define-color background #1d2021;
          @define-color background2  #1f2223;
          @define-color background2-bottom  #191c1d;
          @define-color background3 #303030;
          @define-color background3-bottom  #272727;
          @define-color background4 #282828;
          @define-color background4-bottom  #252c32;
          @define-color window-border  #689d6a;
          @define-color window-border-inactive  #1d2021;
          @define-color close-button  #e23c2c;
          @define-color close-button-bottom  #cc241d;
          @define-color close-button-foreground  #282828;
          @define-color powermenu-button  #e23c2c;
          @define-color powermenu-button-bottom  #cc241d;
          @define-color powermenu-button-foreground  #282828;
          @define-color slider  #689d6a;
          @define-color metric-slider  #689d6a;
          @define-color metric-slider-background  #3c3836;
          @define-color metric-slider-foreground  #8ec07c;
          @define-color button  #689d6a;
          @define-color button-bottom  #518554;
          @define-color button-active  #7db37e;
          @define-color button-bottom-active  #659a68;
          @define-color button-hover  #8ec07c;
          @define-color button-bottom-hover  #76a765;
          @define-color button-foreground  #282828;
          @define-color cc-bg  #1d2021;
          @define-color noti-border-color  #689d6a;
          @define-color noti-border-color-critical  #cc241d;
          @define-color noti-bg  #1d2021;
          @define-color noti-bg-darker  #1d2021;
          @define-color noti-bg-hover  #1d2021;
          @define-color noti-close-bg #3c3836;
          @define-color noti-close-bg-hover  #cc241d;
          @define-color dnd-bg  #3c3836;
          @define-color dnd-selected  #689d6a;
          @define-color dnd-dot  #282828;
          @define-color noti-button  #282828;
          @define-color noti-button-hover  #3c3836;
          @define-color waybar-module-foreground  #282828;
          @define-color waybar-clock  #98971a;
          @define-color waybar-clock-bottom  #828200;
          @define-color waybar-battery  #5d9da0;
          @define-color waybar-battery-bottom  #458588;
          @define-color waybar-battery-critical  #e23c2c;
          @define-color waybar-battery-bottom-critical  #cc241d;
          @define-color waybar-cpu  #689d6a;
          @define-color waybar-cpu-bottom  #518554;
          @define-color waybar-memory  #c8779b;
          @define-color waybar-memory-bottom  #b16286;
          @define-color waybar-backlight  #98bbad;
          @define-color waybar-backlight-bottom  #80a295;
          @define-color waybar-pulseaudio  #f2b13c;
          @define-color waybar-pulseaudio-bottom  #d79921;
          @define-color waybar-tray  #ec7024;
          @define-color waybar-tray-bottom  #d05806;
          @define-color terminal-black  #323536;
          @define-color terminal-black-bright  #444748;
          @define-color terminal-red  #cc241d;
          @define-color terminal-red-bright  #fb4934;
          @define-color terminal-green  #98971a;
          @define-color terminal-green-bright  #b8bb26;
          @define-color terminal-yellow  #d79921;
          @define-color terminal-yellow-bright  #fabd2f;
          @define-color terminal-blue  #458588;
          @define-color terminal-blue-bright  #83a598;
          @define-color terminal-magenta  #b16286;
          @define-color terminal-magenta-bright  #d3869b;
          @define-color terminal-cyan  #689d6a;
          @define-color terminal-cyan-bright  #8ec07c;
          @define-color terminal-white  #ebdbb2;
          @define-color terminal-white-bright  #fbf1c7;



          * {
              font-family: JetBrainsMono Nerd Font, FontAwesome, Roboto, Helvetica, Arial, sans-serif;
              font-size: 14px;
              font-weight: bold;
          }

          window#waybar {
              background-color: #${background2};
              border-bottom: 8px solid #${background2-bottom};
              color: @foreground;
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
              background-color: @button;
              color: @button-foreground;
              border: none;
              border-bottom: 8px solid @button-bottom;
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
              background-color: @button-hover;
              border-bottom: 8px solid @button-bottom-hover;
          }

          button.active {
              background: inherit;
              background-color: @button-active;
              border-bottom: 8px solid @button-bottom-active;
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
              background-color: @background3;
              color: @foreground;
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid @background3-bottom;
              border-radius: 5px;
              margin-bottom: 2px;
              padding-left: 10px;
              padding-right: 10px;
          }

          #custom-notification {
              background-color: @button;
              color: @button-foreground;
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 18px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid @button-bottom;
              border-radius: 5px;
              margin-bottom: 2px;
              padding-left: 13px;
              padding-right: 9px;
          }

          #custom-menu {
              background-color: @button;
              color: @button-foreground;
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 18px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid @button-bottom;
              border-radius: 5px;
              margin-bottom: 2px;
              padding-left: 14px;
              padding-right: 8px;
          }

          #custom-powermenu {
              background-color: #${powermenu-button};
              color: @powermenu-button-foreground;
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 22px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid @powermenu-button-bottom;
              border-radius: 5px;
              margin-bottom: 2px;
              margin-right: 4px;
              padding-left: 14px;
              padding-right: 7px;
          }

          #clock {
              background-color: @waybar-clock;
              color: @waybar-module-foreground;
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid @waybar-clock-bottom;
              border-radius: 5px;
              margin-bottom: 2px;
          }

          #battery {
              background-color: @waybar-battery;
              color: @waybar-module-foreground;
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid @waybar-battery-bottom;
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
              background-color: @waybar-battery-critical;
              color: @waybar-module-foreground;
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid @waybar-battery-bottom-critical;
              border-radius: 5px;
              margin-bottom: 2px;
          }

          label:focus {
              background-color: #000000;
          }

          #cpu {
              background-color: @waybar-cpu;
              color: @waybar-module-foreground;
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid @waybar-cpu-bottom;
              border-radius: 5px;
              margin-bottom: 2px;
          }

          #memory {
              background-color: @waybar-memory;
              color: @waybar-module-foreground;
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid @waybar-memory-bottom;
              border-radius: 5px;
              margin-bottom: 2px;
          }

          #disk {
              background-color: #964B00;
          }

          #backlight {
              background-color: @waybar-backlight;
              color: @waybar-module-foreground;
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid @waybar-backlight-bottom;
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
              background-color: @waybar-pulseaudio;
              color: @waybar-module-foreground;
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid @waybar-pulseaudio-bottom;
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
              background-color: @waybar-tray;
              color: @waybar-module-foreground;
              font-family: JetBrainsMono Nerd Font, monospace;
              font-size: 15px;
              font-weight: bold;
              border: none;
              border-bottom: 8px solid @waybar-tray-bottom;
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
              background-color: #2d3436;
          }

          #idle_inhibitor.activated {
              background-color: #ecf0f1;
              color: #2d3436;
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
            background-color: @background2;
            border: none;
            border-bottom: 8px solid @background2-bottom;
            border-radius: 5px;
          }

          tooltip decoration {
            box-shadow: none;
          }

          tooltip decoration:backdrop {
            box-shadow: none;
          }

          tooltip label {
            color: @foreground;
            font-family: JetBrainsMono Nerd Font, monospace;
            font-size: 16px;
            padding-left: 5px;
            padding-right: 5px;
            padding-top: 0px;
            padding-bottom: 5px;
          }
        '';

        # config.json
        settings = {
          mainBar = {
            # margin = "7 7 3 7";
            layer = "top";
            # height = 30;
            spacing = 4;
            modules-left = ["hyprland/workspaces" "hyprland/window"];
            # modules-center = [ "hyprland/window" ];
            modules-right = ["custom/notification" "custom/menu" "tray" "pulseaudio" "cpu" "memory" "backlight" "battery" "clock" "custom/powermenu"];

            /* Modules configuration */
            "hyprland/workspaces" = {
              format = "<span font='11'>{icon}</span>";
              format-icons = {
                # "1"="";
                # "2"="";
                # "3"="";
                # "4"="";
                # "5"="";
                "1" = "1";
                "2" = "2";
                "3" = "3";
                "4" = "4";
                "5" = "5";
                "6" = "6";
                "7" = "7";
                "8" = "8";
              };
              all-outputs = true;
              persistent_workspaces = {
                # "1" = [];
                # "2" = [];
                # "3" = [];
                # "4" = [];
                # "5" = [];
                "1" = [ ];
                "2" = [ ];
                "3" = [ ];
                "4" = [ ];
                "5" = [ ];
                "6" = [ ];
                "7" = [ ];
                "8" = [ ];
              };
            };
            "hyprland/workspaces" = {
              #format = "<span font='11'>{name}</span>";
              active-only = false;
              on-click = "activate";
            };

            "idle_inhibitor"= {
              format= "{icon}";
              format-icons= {
                "activated"= "󰅶";
                "deactivated"= "󰾪";
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
              format = "{icon}{capacity}%";
              tooltip-format = "{timeTo} {capacity}%";
              format-charging = "󱐋 {capacity}%";
              format-plugged = " ";
              format-alt = "{time} {icon}";
              # format-icons = ["  " "  " "  " "  " "  "];
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

            "bluetooth"= {
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
               #on-click = "sleep 0.1 && task-waybar";
               on-click = "sleep 0.1; swaync-client -t -sw";
               on-click-right = "sleep 0.1; swaync-client -d -sw";
               escape = true;
            };

            "custom/menu" = {
              format = " ";
              # on-click = "${pkgs.rofi-wayland}/bin/rofi -show drun";
              on-click = "${pkgs.eww}/bin/eww open --toggle bar-menu --screen 0";
              on-click-release = "sleep 0";
              tooltip = false;
            };

            "custom/powermenu" = {
              format = "⏻ ";
              # on-click = "${pkgs.wlogout}/bin/wlogout -b 2 --protocol layer-shell";
              on-click = "${pkgs.eww}/bin/eww open --toggle powermenu-window --screen 0";
              on-click-release = "sleep 1";
              tooltip = false;
            };
          };
        };
      };
    };
  };
}

