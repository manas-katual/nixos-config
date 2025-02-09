#
#  Hyprland Configuration
#  Enable with "hyprland.enable = true;"
#

{ config, lib, pkgs, userSettings, host, ... }:

with lib;
with host;
{
  options = {
    hyprland = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.hyprland.enable) {
    wlwm.enable = true;

    environment =
      let
        exec = "exec dbus-launch Hyprland";
      in {
        loginShellInit = ''
          if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
            ${exec}
          fi
        '';

        variables = {
          # WLR_NO_HARDWARE_CURSORS="1"; # Needed for VM
          # WLR_RENDERER_ALLOW_SOFTWARE="1";
          XDG_CURRENT_DESKTOP = "Hyprland";
          XDG_SESSION_TYPE = "wayland";
          XDG_SESSION_DESKTOP = "Hyprland";
          # XCURSOR = "Catppuccin-Mocha-Dark-Cursors";
          XCURSOR_SIZE = lib.mkForce 16;
          NIXOS_OZONE_WL = 1;
          SDL_VIDEODRIVER = "wayland";
          OZONE_PLATFORM = "wayland";
          WLR_RENDERER_ALLOW_SOFTWARE = 1;
          CLUTTER_BACKEND = "wayland";
          QT_QPA_PLATFORM = "wayland;xcb";
          QT_QPA_PLATFORMTHEME = "qt6ct";
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
          QT_AUTO_SCREEN_SCALE_FACTOR = 1;
          GDK_BACKEND = "wayland";
          WLR_NO_HARDWARE_CURSORS = "1";
          MOZ_ENABLE_WAYLAND = "1";
        };
        systemPackages = with pkgs; [
          grimblast # Screenshot
          hyprcursor # Cursor
          hyprpaper # Wallpaper
          wl-clipboard # Clipboard
          wlr-randr # Monitor Settings
          xwayland # X session
          #nwg-look
          #hyprpolkitagent
        ];
      };

    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    programs.light.enable = true;

    security.pam.services.hyprlock = {
      # text = "auth include system-auth";
      text = "auth include login";
      enableGnomeKeyring = true;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
          command = "${config.programs.hyprland.package}/bin/Hyprland"; # tuigreet not needed with exec-once hyprlock
          user = userSettings.username;
        };
      };
      vt = 7;
    };

    systemd.sleep.extraConfig = ''
      AllowSuspend=yes
      AllowHibernation=no
      AllowSuspendThenHibernate=no
      AllowHybridSleep=yes
    ''; # Clamshell Mode

    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    home-manager.users.${userSettings.username} =
      let
        lid = if hostName == "dell" then "LID0" else "LID";
        lockScript = pkgs.writeShellScript "lock-script" ''
          action=$1
          ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg running
          if [ $? == 1 ]; then
            if [ "$action" == "lock" ]; then
              ${pkgs.hyprlock}/bin/hyprlock
            elif [ "$action" == "suspend" ]; then
              ${pkgs.systemd}/bin/systemctl suspend
            fi
          fi
        '';
      in
      {
        #imports = [
        #  hyprland.homeManagerModules.default
        #];

        programs.hyprlock = {
          enable = true;
          settings = {
            general = {
              hide_cursor = true;
              no_fade_in = false;
              disable_loading_bar = true;
              grace = 0;
            };
            background = lib.mkForce [{
              monitor = "";
              path = "$HOME/setup/modules/wallpapers/hyprland.png";
              color = "rgba(25, 20, 20, 1.0)";
              blur_passes = 1;
              blur_size = 0;
              brightness = 0.2;
            }];
            input-field = lib.mkForce [
              {
                monitor = "";
                size = "250, 60";
                outline_thickness = 2;
                dots_size = 0.2;
                dots_spacing = 0.2;
                dots_center = true;
                outer_color = "rgba(0, 0, 0, 0)";
                inner_color = "rgba(0, 0, 0, 0.5)";
                font_color = "rgb(200, 200, 200)";
                fade_on_empty = false;
                placeholder_text = ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
                hide_input = false;
                position = "0, -120";
                halign = "center";
                valign = "center";
              }
            ];
            label = [
              {
                monitor = "";
                text = "$TIME";
                font_size = 120;
                position = "0, 80";
                valign = "center";
                halign = "center";
              }
            ];
          };
        };

        services.hypridle = {
          enable = true;
          settings = {
            general = {
              before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
              after_sleep_cmd = "${config.programs.hyprland.package}/bin/hyprctl dispatch dpms on";
              ignore_dbus_inhibit = true;
              lock_cmd = "pidof ${pkgs.hyprlock}/bin/hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
            };
            listener = [
              {
                timeout = 300;
                on-timeout = "${lockScript.outPath} lock";
              }
              {
                timeout = 1800;
                on-timeout = "${lockScript.outPath} suspend";
              }
            ];
          };
        };

        services.hyprpaper = {
          enable = true;
          settings = {
            ipc = true;
            splash = false;
            preload = [ ''+config.stylix.image+'' ];
            wallpaper = [ ''+config.stylix.image+'' ];
          };
        };

        wayland.windowManager.hyprland =  {
          enable = true;
          #package = hyprland.packages.${pkgs.system}.hyprland;
          xwayland.enable = true;
          # plugins = [
          #   hyprspace.packages.${pkgs.system}.Hyprspace
          # ];
          # # plugin settings
          # extraConfig = ''
          #   bind=SUPER,Tab,overview:toggle
          #   plugin:overview:panelHeight=150
          #   plugin:overview:drawActiveWorkspace=false
          #   plugin:overview:gapsIn=3
          #   plugin:overview:gapsOut=6
          # '';
          settings = {
            general = {
              border_size = 2;
              gaps_in = 3;
              gaps_out = 6;
              "col.active_border" = lib.mkDefault "0x99${config.lib.stylix.colors.base0D}";
              "col.inactive_border" = lib.mkDefault "0x66${config.lib.stylix.colors.base02}";
              resize_on_border = true;
              hover_icon_on_border = false;
              layout = "dwindle";
            };
            decoration = {
              rounding = 1;
              active_opacity = 1;
              inactive_opacity = 1;
              fullscreen_opacity = 1;
            };
            monitor = (if (hostName == "dell") then "HDMI-A-1,1366x768,auto,1,mirror,LVDS-1" else "HDMI-A-1,preferred,auto,1,mirror,LVDS-1");
            animations = {
              enabled = true;
              bezier = [
                "overshot, 0.05, 0.9, 0.1, 1.05"
                "smooth, 0.5, 0, 0.99, 0.99"
                "snapback, 0.54, 0.42, 0.01, 1.34"
                "curve, 0.27, 0.7, 0.03, 0.99"
              ];
              animation = [
                "windows, 1, 5, overshot, slide"
                "windowsOut, 1, 5, snapback, slide"
                "windowsIn, 1, 5, snapback, slide"
                "windowsMove, 1, 5, snapback, slide"
                "border, 1, 5, default"
                "fade, 1, 5, default"
                "fadeDim, 1, 5, default"
                "workspaces, 1, 6, curve"
              ];
            };
            input = {
              kb_layout = "us";
              # kb_layout=us,us
              # kb_variant=,dvorak
              # kb_options=caps:ctrl_modifier
              kb_options = "caps:escape";
              follow_mouse = 2;
              repeat_delay = 250;
              numlock_by_default = 1;
              accel_profile = "flat";
              sensitivity = 0.8;
              natural_scroll = false;
              touchpad =
                if hostName == "dell" then {
                  natural_scroll = true;
                  scroll_factor = 0.2;
                  middle_button_emulation = true;
                  tap-to-click = true;
                } else { };
            };
            device = {
              name = "manas-magic-mouse";
              sensitivity = 0.5;
              natural_scroll = true;
            };
            cursor = {
              no_hardware_cursors = true;
            };
            gestures =
              if hostName == "dell" then {
                workspace_swipe = true;
                workspace_swipe_fingers = 3;
                workspace_swipe_distance = 100;
                workspace_swipe_create_new = true;
              } else { };
            dwindle = {
              pseudotile = false;
              force_split = 2;
              preserve_split = true;
            };
            misc = {
              disable_hyprland_logo = true;
              disable_splash_rendering = true;
              mouse_move_enables_dpms = true;
              mouse_move_focuses_monitor = true;
              key_press_enables_dpms = true;
              background_color = lib.mkDefault "0x111111";
            };
            debug = {
              damage_tracking = 2;
            };
            bindm = [
              "SUPER,mouse:272,movewindow"
              "SUPER,mouse:273,resizewindow"
            ];
            bind = [
              "SUPER,Return,exec,${pkgs.${userSettings.terminal}}/bin/${userSettings.terminal}"
              "SUPER,Q,killactive,"
              "SUPER,Escape,exit,"
              "SUPER,S,exec,${pkgs.systemd}/bin/systemctl suspend"
              "SUPER,L,exec,${pkgs.hyprlock}/bin/hyprlock"
              "SUPER,E,exec,${pkgs.pcmanfm}/bin/pcmanfm"
              "SUPER,F,togglefloating,"
              #"SUPER,Space,exec, pkill wofi || ${pkgs.wofi}/bin/wofi --show drun"
              "SUPER,Space,exec, pkill rofi || ${pkgs.rofi-wayland}/bin/rofi -show drun"
              "SUPER,P,pseudo,"
              ",F11,fullscreen,"
              "SUPER,R,forcerendererreload"
              "SUPERSHIFT,R,exec,${config.programs.hyprland.package}/bin/hyprctl reload"
              "SUPER,T,exec,${pkgs.${userSettings.terminal}}/bin/${userSettings.terminal} -e nvim"
              # "SUPER,K,exec,${config.programs.hyprland.package}/bin/hyprctl switchxkblayout keychron-k8-keychron-k8 next"
              "SUPER,Z,layoutmsg,togglesplit"
              "SUPER,F1,exec,~/.config/hypr/gamemode.sh"
              "SUPER,F2,exec,hyprpanel toggleWindow bar-0"
              "ALT,F4,exec,hyprpanel toggleWindow powerdropdownmenu"
              "SUPER,TAB,exec,pkill -SIGUSR1 waybar"

              "SUPER,left,movefocus,l"
              "SUPER,right,movefocus,r"
              "SUPER,up,movefocus,u"
              "SUPER,down,movefocus,d"
              "SUPERSHIFT,left,movewindow,l"
              "SUPERSHIFT,right,movewindow,r"
              "SUPERSHIFT,up,movewindow,u"
              "SUPERSHIFT,down,movewindow,d"
              "SUPER,1,workspace,1"
              "SUPER,2,workspace,2"
              "SUPER,3,workspace,3"
              "SUPER,4,workspace,4"
              "SUPER,5,workspace,5"
              "SUPER,6,workspace,6"
              "SUPER,7,workspace,7"
              "SUPER,8,workspace,8"
              "SUPER,9,workspace,9"
              "SUPER,0,workspace,10"
              #"SUPER,right,workspace,+1"
              #"SUPER,left,workspace,-1"
              "SUPERSHIFT,1,movetoworkspace,1"
              "SUPERSHIFT,2,movetoworkspace,2"
              "SUPERSHIFT,3,movetoworkspace,3"
              "SUPERSHIFT,4,movetoworkspace,4"
              "SUPERSHIFT,5,movetoworkspace,5"
              "SUPERSHIFT,6,movetoworkspace,6"
              "SUPERSHIFT,7,movetoworkspace,7"
              "SUPERSHIFT,8,movetoworkspace,8"
              "SUPERSHIFT,9,movetoworkspace,9"
              "SUPERSHIFT,0,movetoworkspace,10"
              #"SUPERSHIFT,right,movetoworkspace,+1"
              #"SUPERSHIFT,left,movetoworkspace,-1"

              ",print,exec,${pkgs.grimblast}/bin/grimblast --notify --freeze --wait 1 copysave area ~/Pictures/Screenshots/$(date +%Y-%m-%dT%H%M%S).png"
              ",XF86AudioLowerVolume,exec,${pkgs.pamixer}/bin/pamixer -d 10"
              ",XF86AudioRaiseVolume,exec,${pkgs.pamixer}/bin/pamixer -i 10"
              ",XF86AudioMute,exec,${pkgs.pamixer}/bin/pamixer -t"
              "SUPER_L,c,exec,${pkgs.pamixer}/bin/pamixer --default-source -t"
              "CTRL,F10,exec,${pkgs.pamixer}/bin/pamixer -t"
              ",XF86AudioMicMute,exec,${pkgs.pamixer}/bin/pamixer --default-source -t"
              ",XF86MonBrightnessDown,exec,${pkgs.light}/bin/light -U 10"
              ",XF86MonBrightnessUP,exec,${pkgs.light}/bin/light -A 10"
            ];
            binde = [
              "SUPERCTRL,right,resizeactive,60 0"
              "SUPERCTRL,left,resizeactive,-60 0"
              "SUPERCTRL,up,resizeactive,0 -60"
              "SUPERCTRL,down,resizeactive,0 60"
            ];
            bindl =
              if hostName == "dell" then [
                ",switch:Lid Switch,exec,$HOME/.config/hypr/script/clamshell.sh"
              ] else [ ];
            windowrule = [
              "float, ^(mpv)$"
            ];
            windowrulev2 = [
              "float,title:^(Volume Control)$"
              "float,title:^(Authentication Required)$"

              "keepaspectratio,class:^(google-chrome)$,title:^(Picture-in-Picture)$"
              "noborder,class:^(google-chrome)$,title:^(Picture-in-Picture)$"
              "float, title:^(Picture-in-Picture)$"
              "size 24% 24%, title:(Picture-in-Picture)"
              "move 75% 75%, title:(Picture-in-Picture)"
              "pin, title:^(Picture-in-Picture)$"
              "float, title:^(Google Chrome)$"
              "size 24% 24%, title:(Google Chrome)"
              "move 74% 74%, title:(Google Chrome)"
              "pin, title:^(Google Chrome)$"

              "workspace 3, class:^(google-chrome)$"
              "workspace 2, class:^(Emacs)$"
              "workspace 8, class:^(.virt-manager-wrapped)$"

              "opacity 0.9, class:^(kitty)"
              #"tile,initialTitle:^WPS.*"
            ];
            exec-once = [
              "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent"
              # "${pkgs.hyprpanel}/bin/hyprpanel"
              "emacs --daemon"
              "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
              "${pkgs.hyprlock}/bin/hyprlock"
              "ln -s $XDG_RUNTIME_DIR/hypr /tmp/hypr"
              # "${pkgs.hyprpaper}/bin/hyprpaper"
            ] ++ (if userSettings.bar == "waybar" then [
                "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"
              #"${pkgs.rclone}/bin/rclone mount --daemon gdrive: /GDrive --vfs-cache-mode=writes"
              # "${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse /GDrive"
                "${pkgs.waybar}/bin/waybar -c $HOME/.config/waybar/config"
                "${pkgs.eww}/bin/eww daemon"
                # "$HOME/.config/eww/scripts/eww" # When running eww as a bar
                "${pkgs.blueman}/bin/blueman-applet"
                "${pkgs.swaynotificationcenter}/bin/swaync" 
            ] 
              else if userSettings.bar == "hyprpanel" then [
                "${pkgs.hyprpanel}/bin/hyprpanel"
                ]
              else [ ]);
            # env = [
            #   "XCURSOR,Catppuccin-Mocha-Dark-Cursors"
            #   "XCURSOR_SIZE,24"
            # ];
          };
        };
        home.file = {
          ".config/hypr/script/clamshell.sh" = {
            text = ''
              #!/bin/sh

              if grep open /proc/acpi/button/lid/${lid}/state; then
                ${config.programs.hyprland.package}/bin/hyprctl keyword monitor "${toString mainMonitor}, 1336x768, 0x0, 1"
              else
                if [[ `hyprctl monitors | grep "Monitor" | wc -l` != 1 ]]; then
                  ${config.programs.hyprland.package}/bin/hyprctl keyword monitor "${toString mainMonitor}, disable"
                else
                  ${pkgs.hyprlock}/bin/hyprlock
                  ${pkgs.systemd}/bin/systemctl suspend
                fi
              fi
            '';
            executable = true;
          };
        };
        home.file = {
          ".config/uwsm/env-hyprland" = {
            text = ''
              export AQ_DRM_DEVICES="/dev/dri/card1:/dev/dri/card2" 
            '';
          };
        };
        home.file = {
          ".config/hypr/gamemode.sh" = {
            text = ''
              #!/usr/bin/env sh

              HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
              if [ "$HYPRGAMEMODE" = 1 ] ; then
                  hyprctl --batch "\
                      keyword animations:enabled 0;\
                      keyword decoration:shadow:enabled 0;\
                      keyword decoration:blur:enabled 0;\
                      keyword general:gaps_in 0;\
                      keyword general:gaps_out 0;\
                      keyword general:border_size 1;\
                      keyword decoration:rounding 0"
                  exit
              fi
              hyprctl reload
            '';
            executable = true;
          };
        };
	    };
	};
}
