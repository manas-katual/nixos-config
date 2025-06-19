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
      "custom/right-arrow-dark"
      "custom/right-arrow-light"
      "idle_inhibitor"
      "custom/right-arrow-dark"
      "custom/right-arrow-light"
      "custom/right-arrow-dark2"
    ]
    else if sway.enable == true
    then [
      "sway/workspaces"
      "custom/right-arrow-dark"
      "custom/right-arrow-light"
      "idle_inhibitor"
      "custom/right-arrow-dark"
      "custom/right-arrow-light"
      "custom/right-arrow-dark2"
    ]
    else if niri.enable == true
    then [
      "niri/workspaces"
      "custom/right-arrow-dark"
      "custom/right-arrow-light"
      "idle_inhibitor"
      "custom/right-arrow-dark"
      "custom/right-arrow-light"
      "custom/right-arrow-dark2"
    ]
    else [];

  commonWorkspaces = {
    format = "<span font='11'>{name}</span>: <span font='11'>{icon}</span>";
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
      "*" = 0;
    };
    active-only = false;
    on-click = "activate";
  };
in {
  config = lib.mkIf (config.wlwm.enable && userSettings.style == "waybar-cool") {
    home-manager.users.${userSettings.username} = {
      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            modules-left = modules-left;
            modules-center = [
              "custom/left-arrow-dark2"
              "custom/left-arrow-light"
              "custom/left-arrow-dark"
              "clock#1"
              "custom/left-arrow-light"
              "custom/left-arrow-dark"
              "clock#2"
              "custom/right-arrow-dark"
              "custom/right-arrow-light"
              "clock#3"
              "custom/right-arrow-dark"
              "custom/right-arrow-light"
              "custom/right-arrow-dark2"
            ];
            modules-right = [
              "custom/left-arrow-dark2"
              "custom/left-arrow-light"
              "custom/left-arrow-dark"
              "custom/notification"
              "custom/left-arrow-light"
              "custom/left-arrow-dark"
              "pulseaudio"
              "custom/left-arrow-light"
              "custom/left-arrow-dark"
              "tray"
              "custom/left-arrow-light"
              "custom/left-arrow-dark"
              "battery"
              "custom/left-arrow-light"
              "custom/left-arrow-dark"
              "custom/powermenu"
            ];
            "sway/workspaces" = commonWorkspaces;
            "niri/workspaces" = commonWorkspaces;
            "wlr/workspaces" = {
              format = "<span font='11'>{name}</span>";
              active-only = false;
              on-click = "activate";
            };
            "hyprland/workspaces" =
              commonWorkspaces
              // {
                #format = "<span font='11'>{name}</span>";
                on-scroll-up = "hyprctl dispatch workspace e-1";
                on-scroll-down = "hyprctl dispatch workspace e+1";
                disable-scroll = "false";
              };

            "custom/left-arrow-dark" = {
              format = " ";
              tooltip = "false";
            };
            "custom/left-arrow-dark2" = {
              format = " ";
              "tooltip" = "false";
            };
            "custom/left-arrow-light" = {
              format = " ";
              tooltip = "false";
            };
            "custom/right-arrow-dark" = {
              format = " ";
              tooltip = "false";
            };
            "custom/right-arrow-dark2" = {
              format = " ";
              tooltip = "false";
            };
            "custom/right-arrow-light" = {
              format = " ";
              tooltip = "false";
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

            "clock#1" = {
              format = "{:%a}";
              tooltip = "false";
            };
            "clock#2" = {
              format = "{:%I:%M %p}";
              tooltip = "false";
            };
            "clock#3" = {
              format = "{:%m-%d}";
              tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
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
          	font-size: 14px;
          	min-height: 0;
          	font-family: JetBrainsMono Nerd Font, FontAwesome, Roboto, Helvetica, Arial, sans-serif;
          	font-weight: Bold;
          	border: 2px;
          }

          window#waybar {
          	background: rgba(21, 18, 27, 0);
          	color: #${config.lib.stylix.colors.base05};
          }

          #custom-right-arrow-dark,
          #custom-left-arrow-dark {
          	color: #${config.lib.stylix.colors.base00};
          	background: #${config.lib.stylix.colors.base01};
          }

          #custom-right-arrow-dark2,
          #custom-left-arrow-dark2 {
          	color: #${config.lib.stylix.colors.base00};
          }

          #custom-right-arrow-light,
          #custom-left-arrow-light {
          	background: #${config.lib.stylix.colors.base00};
          	color: #${config.lib.stylix.colors.base01};
          }

          #custom-notification {
          	color: #${config.lib.stylix.colors.base0D};
          	background: #${config.lib.stylix.colors.base00};
          }

          #workspaces,
          #clock.1 {
          	color: #${config.lib.stylix.colors.base06};
          	background: #${config.lib.stylix.colors.base00};
          }

          #clock.2 {
          	color: #${config.lib.stylix.colors.base0D};
          	background: #${config.lib.stylix.colors.base00};
          }

          #clock.3 {
          	color: #${config.lib.stylix.colors.base06};
          	background: #${config.lib.stylix.colors.base00};
          }

          #pulseaudio,
          #memory,
          #cpu,
          #battery,
          #disk,
          #tray,
          #idle_inhibitor {
          	background: #${config.lib.stylix.colors.base00};
          	padding-right: 10px;
          	padding-left: 10px;
          }

          #workspaces button {
          	padding: 0 2px;
          	color: #${config.lib.stylix.colors.base05};
          }

          #workspaces button.active {
          	color: #${config.lib.stylix.colors.base08};
          }

          #workspaces button:hover {
          	box-shadow: inherit;
          	text-shadow: inherit;
          	background: #${config.lib.stylix.colors.base00};
          	padding: 0 3px;
          }

          #pulseaudio {
          	color: #${config.lib.stylix.colors.base03};
          }

          #memory {
          	color: #${config.lib.stylix.colors.base0C};
          }

          #custom-powermenu {
          	background: #${config.lib.stylix.colors.base00};
          	color: #${config.lib.stylix.colors.base08};
          	/* Alternative: color: #${config.lib.stylix.colors.base0A}; */
          }

          #battery {
          	color: #${config.lib.stylix.colors.base04};
          }

          #cpu {
          	color: #${config.lib.stylix.colors.base03};
          }

          #disk {
          	color: #${config.lib.stylix.colors.base0A};
          }

          #clock,
          #pulseaudio,
          #memory,
          #cpu,
          #battery,
          #disk {
          	padding: 0 10px;
          }
        '';
      };
    };
  };
}
