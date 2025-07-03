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
  options = {
    sway = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  config = mkIf (config.sway.enable) {
    wlwm.enable = true;

    environment = {
      loginShellInit = ''
         if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
         exec sway
        fi
      '';
      variables = {
        WLR_NO_HARDWARE_CURSORS = "1";
      };
    };

    programs = {
      sway = {
        enable = true;
        extraPackages = with pkgs; [
          autotiling
          wl-clipboard
          wlr-randr
          xwayland
          libnotify
          jq
        ];
      };
      light = {
        enable = true;
      };
    };

    home-manager.users.${userSettings.username} = {
      wayland.windowManager.sway = {
        enable = true;
        config = rec {
          modifier = "Mod4";
          terminal = "${pkgs.${userSettings.terminal}}/bin/${userSettings.terminal}";
          menu = "${pkgs.wofi}/bin/wofi --show drun";

          startup = [
            {
              command = "${pkgs.autotiling}/bin/autotiling";
              always = true;
            }
            {command = "${pkgs.blueman}/bin/blueman-applet";}
            {command = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";}
          ];

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

          window = {
            titlebar = false;
          };

          gaps = {
            inner = 3;
            outer = 3;
          };

          input = {
            # Input modules: $ man sway-input
            "type:touchpad" = {
              tap = "enabled";
              dwt = "enabled";
              scroll_method = "two_finger";
              middle_emulation = "enabled";
              natural_scroll = "enabled";
            };
            "type:keyboard" = {
              xkb_layout = "in";
              xkb_variant = "eng";
              xkb_numlock = "enabled";
            };
          };

          #output = {};

          keybindings = {
            "${modifier}+Escape" = "exec swaymsg exit";
            "${modifier}+Return" = "exec ${terminal}";
            "${modifier}+space" = "exec ${menu}";

            "${modifier}+r" = "reload";
            "${modifier}+q" = "kill";
            "${modifier}+f" = "fullscreen toggle";
            "${modifier}+h" = "floating toggle";

            "${modifier}+Left" = "focus left";
            "${modifier}+Right" = "focus right";
            "${modifier}+Up" = "focus up";
            "${modifier}+Down" = "focus down";

            "${modifier}+1" = "workspace number 1";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";
            "${modifier}+6" = "workspace number 6";
            "${modifier}+7" = "workspace number 7";
            "${modifier}+8" = "workspace number 8";
            "${modifier}+9" = "workspace number 9";

            "${modifier}+Shift+Left" = "move container to workspace prev, workspace prev";
            "${modifier}+Shift+Right" = "move container to workspace next, workspace next";

            "${modifier}+Shift+1" = "move container to workspace number 1";
            "${modifier}+Shift+2" = "move container to workspace number 2";
            "${modifier}+Shift+3" = "move container to workspace number 3";
            "${modifier}+Shift+4" = "move container to workspace number 4";
            "${modifier}+Shift+5" = "move container to workspace number 5";
            "${modifier}+Shift+6" = "move container to workspace number 6";
            "${modifier}+Shift+7" = "move container to workspace number 7";
            "${modifier}+Shift+8" = "move container to workspace number 8";
            "${modifier}+Shift+9" = "move container to workspace number 9";

            "Print" = "exec screenshot";

            "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 10";
            "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 10";
            "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
            "XF86AudioMicMute" = "exec ${pkgs.pamixer}/bin/pamixer --default-source -t";

            "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
            "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl ser 5%-";
          };
        };
        extraConfig = ''
          exec ${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent
          for_window [title="Authentication Required"] floating enable, resize set 600 200
          exec ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator
          exec ${pkgs.blueman}/bin/blueman-applet
          set $opacity 0.8
          for_window [class=".*"] opacity 0.95
          for_window [app_id=".*"] opacity 0.95
          #for_window [app_id="thunar"] opacity 0.95, floating enable
          for_window [app_id="com.github.weclaw1.ImageRoll"] opacity 0.95, floating enable
          for_window [app_id="kitty"] opacity $opacity
          for_window [title="drun"] opacity $opacity
          #for_window [class="Emacs"] opacity $opacity
          for_window [app_id="pavucontrol"] floating enable, sticky
          for_window [app_id="blueberry.py"] floating enable, sticky
          #for_window [app_id=".blueman-manager-wrapped"] floating enable
          for_window [title="Picture in picture"] floating enable, move position 1205 634, resize set 700 400, sticky enable
        ''; # $ swaymsg -t get_tree or get_outputs
        extraSessionCommands = ''
          #export WLR_NO_HARDWARE_CURSORS="1";  # Needed for cursor in vm
          export XDG_SESSION_TYPE=wayland
          export XDG_SESSION_DESKTOP=sway
          export XDG_CURRENT_DESKTOP=sway
        '';
      };
      services.swayidle = {
        enable = true;
        events = [
          {
            event = "before-sleep";
            command = "${pkgs.swaylock-effects}/bin/swaylock --daemonize";
          }
          {
            event = "lock";
            command = "${pkgs.swaylock-effects}/bin/swaylock --daemonize --grace 0";
          }
          {
            event = "unlock";
            command = "pkill -SIGUSR1 swaylock";
          }
          {
            event = "after-resume";
            command = "swaymsg \"output * dpms on\"";
          }
        ];
        timeouts = [
          {
            timeout = 1800;
            command = "${pkgs.swaylock-effects}/bin/swaylock --daemonize";
          }
          {
            timeout = 2000;
            command = "swaymsg \"output * dpms off\"";
            resumeCommand = "swaymsg \"output * dpms on\"";
          }
        ];
      };
      programs.swaylock = {
        enable = true;
        package = pkgs.swaylock-effects;
        settings = {
          color = lib.mkForce "#''+stylix.colors.base04+''";
          clock = true;
          font-size = 24;
          fade-in = 0.2;
          grace = 5;
          indicator-idle-visible = true;
          indicator-radius = 100;
          line-color = lib.mkForce "#''+stylix.colors.base00+''";
          show-failed-attempts = true;
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
