#
#  Sway Configuration
#  Enable with "sway.enable = true;"
#
{
  config,
  lib,
  pkgs,
  userSettings,
  host,
  ...
}:
with lib;
with host; {
  config = mkIf (config.sway.enable) {
    home-manager.users.${userSettings.username} = {
      wayland.windowManager.sway = {
        config = rec {
          bars = [
            # {command = "${pkgs.waybar}/bin/waybar";}
            {
              position = "top";
              statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
              fonts = {
                names = lib.mkDefault ["FontAwesome6" "DejaVu Sans Mono"];
                # size = config.stylix.fonts.sizes.terminal * 1.0;
              };
              colors = {
                background = "#${config.lib.stylix.colors.base00}";
                statusline = "#${config.lib.stylix.colors.base05}";
                separator = "#${config.lib.stylix.colors.base03}";

                focusedWorkspace = {
                  border = "#${config.lib.stylix.colors.base0D}";
                  background = "#${config.lib.stylix.colors.base0D}";
                  text = "#${config.lib.stylix.colors.base00}";
                };
                activeWorkspace = {
                  border = "#${config.lib.stylix.colors.base03}";
                  background = "#${config.lib.stylix.colors.base03}";
                  text = "#${config.lib.stylix.colors.base05}";
                };
                inactiveWorkspace = {
                  border = "#${config.lib.stylix.colors.base01}";
                  background = "#${config.lib.stylix.colors.base01}";
                  text = "#${config.lib.stylix.colors.base04}";
                };
                urgentWorkspace = {
                  border = "#${config.lib.stylix.colors.base08}";
                  background = "#${config.lib.stylix.colors.base08}";
                  text = "#${config.lib.stylix.colors.base00}";
                };
                bindingMode = {
                  border = "#${config.lib.stylix.colors.base0A}";
                  background = "#${config.lib.stylix.colors.base0A}";
                  text = "#${config.lib.stylix.colors.base00}";
                };
              };
            }
          ];
        };
      };
      programs.i3status-rust = {
        enable = true;
        bars.default = {
          # This tells i3status-rust to not take the whole bar
          settings = {
            theme = {
              theme = "ctp-frappe";
              overrides = {
                idle_bg = "#${config.lib.stylix.colors.base00}";
                idle_fg = "#${config.lib.stylix.colors.base05}";
                info_bg = "#${config.lib.stylix.colors.base0D}";
                info_fg = "#${config.lib.stylix.colors.base00}";
                good_bg = "#${config.lib.stylix.colors.base0B}";
                good_fg = "#${config.lib.stylix.colors.base00}";
                warning_bg = "#${config.lib.stylix.colors.base0A}";
                warning_fg = "#${config.lib.stylix.colors.base00}";
                critical_bg = "#${config.lib.stylix.colors.base08}";
                critical_fg = "#${config.lib.stylix.colors.base00}";
                separator = "#${config.lib.stylix.colors.base03}";
                separator_bg = "auto";
                separator_fg = "auto";
              };
            };

            icons = {
              icons = "awesome6";
              overrides = {
                bluetooth = "󰂯";
                bluetooth_off = "󰂲";
                battery_full = "󰁹";
                battery_charging = "󰂄";
                battery_discharging = "󰂃";
                battery_empty = "󰂎";
                brightness = "󰃠";
                volume_full = "󰕾";
                volume_half = "󰖀";
                volume_low = "󰕿";
                volume_muted = "󰖁";
                microphone = "󰍬";
                microphone_muted = "󰍭";
                net_wireless = "󰖩";
                net_wired = "󰈀";
                net_down = "󰈂";
                cpu = "󰘚";
                memory = "󰍛";
                disk_drive = "󰋊";
                time = "󰥔";
                calendar = "󰃭";
                logout = "";
              };
            };
          };

          blocks = [
            # Bluetooth block
            {
              block = "bluetooth";
              format = " $icon $name{ $percentage|} ";
              disconnected_format = " $icon Off ";
            }

            # Battery block
            {
              block = "battery";
              interval = 10;
              format = " $icon $percentage ";
              full_format = " $icon Full ";
              empty_format = " $icon Empty ";
              not_charging_format = " $icon $percentage ";
              missing_format = "";
            }

            # Brightness block
            {
              block = "backlight";
              format = " $icon $brightness ";
            }

            # Volume block
            {
              block = "sound";
              format = " $icon $volume ";
              headphones_indicator = true;
              show_volume_when_muted = true;
              click = [
                {
                  button = "left";
                  cmd = "${pkgs.pavucontrol}/bin/pavucontrol";
                }
              ];
            }

            # Microphone
            {
              block = "sound";
              device_kind = "source";
              format = " $icon $volume ";
              show_volume_when_muted = true;
            }

            # Network block
            {
              block = "net";
              format = " $icon $signal_strength $ssid ";
              format_alt = " $icon $ip ";
              missing_format = " $icon Down ";
              click = [
                {
                  button = "left";
                  cmd = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
                }
              ];
            }

            # CPU block
            {
              block = "cpu";
              interval = 1;
              format = " $icon $barchart $utilization ";
              format_alt = " $icon $frequency ";
            }

            # Memory block
            {
              block = "memory";
              interval = 5;
              format = " $icon $mem_used_percents ";
              format_alt = " $icon $mem_used/$mem_total ";
              warning_mem = 80;
              critical_mem = 95;
            }

            # Disk space
            {
              block = "disk_space";
              path = "/";
              info_type = "available";
              alert = 10.0;
              warning = 20.0;
              format = " $icon $available ";
              format_alt = " $icon $used/$total ";
            }

            # Date and time
            {
              block = "time";
              interval = 60;
              format = " $icon $timestamp.datetime(f:'%a %d %b') $timestamp.datetime(f:'%H:%M') ";
              click = [
                {
                  button = "left";
                  cmd = "${pkgs.gnome-calendar}/bin/gnome-calendar";
                }
              ];
            }

            # Logout/Power menu
            {
              block = "custom";
              command = "echo ''";
              interval = "once";
              format = "  ";
              click = [
                {
                  button = "left";
                  cmd = "${pkgs.wlogout}/bin/wlogout";
                }
              ];
            }
          ];
        };
      };
    };
  };
}
