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
    format = "{icon}";
    format-icons = {
      "default" = "";
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
      "active" = "󱓻";
    };
    # all-outputs = true;
    persistent_workspaces = {
      "1" = [];
      "2" = [];
      "3" = [];
      "4" = [];
      "5" = [];
      # "6" = [];
      # "7" = [];
      # "8" = [];
      # "9" = [];
      # "10" = [];
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
            spacing = 0;
            height = 26;
            modules-left = modules-left;
            modules-center = [
              "clock"
            ];
            modules-right = [
              "bluetooth"
              "network"
              "pulseaudio"
              "cpu"
              "battery"
            ];
            "hyprland/workspaces" =
              commonWorkspaces
              // {
                on-scroll-up = "hyprctl dispatch workspace e-1";
                on-scroll-down = "hyprctl dispatch workspace e+1";
                disable-scroll = false;
              };
            cpu = {
              interval = 5;
              format = "󰍛";
              on-click = "alacritty -e btop";
            };
            clock = {
              format = "{:%A %H:%M}";
              format-alt = "{:%d %B W%V %Y}";
              tooltip = false;
            };
            network = {
              format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
              format = "{icon}";
              format-wifi = "{icon}";
              format-ethernet = "󰀂";
              format-disconnected = "󰖪";
              tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
              tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
              tooltip-format-disconnected = "Disconnected";
              interval = 3;
              nospacing = 1;
              on-click = "alacritty --class=Impala -e impala";
            };
            battery = {
              format = "{capacity}% {icon}";
              format-discharging = "{icon}";
              format-charging = "{icon}";
              format-plugged = "";
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
              tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}%";
              tooltip-format-charging = "{power:>1.0f}W↑ {capacity}%";
              interval = 5;
              states = {
                warning = 20;
                critical = 10;
              };
            };
            bluetooth = {
              format = "";
              format-disabled = "󰂲";
              format-connected = "";
              tooltip-format = "Devices connected: {num_connections}";
              on-click = "GTK_THEME=Adwaita-dark blueberry";
            };
            pulseaudio = {
              format = "";
              format-muted = "󰝟";
              scroll-step = 5;
              on-click = "GTK_THEME=Adwaita-dark pavucontrol";
              tooltip-format = "Playing at {volume}%";
              on-click-right = "pamixer -t";
              ignored-sinks = ["Easy Effects Sink"];
            };
          };
        };
        style = lib.concatStrings (
          [
            ''
              * {
                border: none;
                border-radius: 0;
                min-height: 0;
                font-family: JetBrainsMono Nerd Font Propo;
                font-size: 12px;
                color: #${config.lib.stylix.colors.base06};
                background-color: #${config.lib.stylix.colors.base00};
              }

              #workspaces {
                margin-left: 7px;
              }

              #workspaces button {
                all: initial;
                padding: 2px 6px;
                margin-right: 3px;
              }

              #custom-dropbox,
              #cpu,
              #battery,
              #network,
              #bluetooth,
              #pulseaudio,
              #clock,
              #custom-power-menu {
                min-width: 12px;
                margin-right: 13px;
              }

              tooltip {
                padding: 2px;
              }

              tooltip label {
                padding: 2px;
              }

            ''
          ]
          # ++ (
          #   if config.sway.enable
          #   then [
          #     ''
          #       #workspaces button.focused {
          #         background-color: #${config.lib.stylix.colors.base0D};
          #         color: #${config.lib.stylix.colors.base00};
          #       }
          #     ''
          #   ]
          #   else [
          #     ''
          #       #workspaces button.active {
          #         background-color: #${config.lib.stylix.colors.base0D};
          #         color: #${config.lib.stylix.colors.base00};
          #       }
          #     ''
          #   ]
          # )
        );
      };
    };
  };
}
