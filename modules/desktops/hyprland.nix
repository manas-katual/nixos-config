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
      in
      {
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
          XCURSOR = "Catppuccin-Mocha-Dark-Cursors";
          XCURSOR_SIZE = lib.mkForce 24;
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
          nwg-look
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
              "col.active_border" = lib.mkDefault "0x99f7870a";
              "col.inactive_border" = lib.mkDefault "0x66f7870a";
              resize_on_border = true;
              hover_icon_on_border = false;
              layout = "dwindle";
            };
            decoration = {
              rounding = 6;
              active_opacity = 1;
              inactive_opacity = 1;
              fullscreen_opacity = 1;
            };
            monitor = (if (hostName == "dell") then "HDMI-A-1,1366x768,auto,1,mirror,LVDS-1" else "HDMI-A-1,preferred,auto,1,mirror,LVDS-1");
            animations = {
              enabled = false;
              bezier = [
                "overshot, 0.05, 0.9, 0.1, 1.05"
                "smoothOut, 0.5, 0, 0.99, 0.99"
                "smoothIn, 0.5, -0.5, 0.68, 1.5"
                "rotate,0,0,1,1"
              ];
              animation = [
                "windows, 1, 4, overshot, slide"
                "windowsIn, 1, 2, smoothOut"
                "windowsOut, 1, 0.5, smoothOut"
                "windowsMove, 1, 3, smoothIn, slide"
                "border, 1, 5, default"
                "fade, 1, 4, smoothIn"
                "fadeDim, 1, 4, smoothIn"
                "workspaces, 1, 4, default"
                "borderangle, 1, 20, rotate, loop"
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
              # "SUPER,E,exec,GDK_BACKEND=x11 ${pkgs.pcmanfm}/bin/pcmanfm"
              "SUPER,E,exec,${pkgs.pcmanfm}/bin/pcmanfm"
              "SUPER,F,togglefloating,"
              "SUPER,Space,exec, pkill wofi || ${pkgs.wofi}/bin/wofi --show drun"
              "SUPER,P,pseudo,"
              ",F11,fullscreen,"
              "SUPER,R,forcerendererreload"
              "SUPERSHIFT,R,exec,${config.programs.hyprland.package}/bin/hyprctl reload"
              "SUPER,T,exec,${pkgs.${userSettings.terminal}}/bin/${userSettings.terminal} -e nvim"
              "SUPER,K,exec,${config.programs.hyprland.package}/bin/hyprctl switchxkblayout keychron-k8-keychron-k8 next"
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
              "SUPER,right,workspace,+1"
              "SUPER,left,workspace,-1"
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
              "SUPERSHIFT,right,movetoworkspace,+1"
              "SUPERSHIFT,left,movetoworkspace,-1"

              "SUPER,Z,layoutmsg,togglesplit"
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
            bindl = [ ];
            windowrulev2 = [
              "float,title:^(Volume Control)$"
              "keepaspectratio,class:^(firefox)$,title:^(Picture-in-Picture)$"
              "noborder,class:^(firefox)$,title:^(Picture-in-Picture)$"
              "float, title:^(Picture-in-Picture)$"
              "size 24% 24%, title:(Picture-in-Picture)"
              "move 75% 75%, title:(Picture-in-Picture)"
              "pin, title:^(Picture-in-Picture)$"
              "float, title:^(Firefox)$"
              "size 24% 24%, title:(Firefox)"
              "move 74% 74%, title:(Firefox)"
              "pin, title:^(Firefox)$"
              "opacity 0.9, class:^(kitty)"
              "tile,initialTitle:^WPS.*"
            ];
            exec-once = [
              "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
              "${pkgs.hyprlock}/bin/hyprlock"
              "ln -s $XDG_RUNTIME_DIR/hypr /tmp/hypr"
              "${pkgs.waybar}/bin/waybar -c $HOME/.config/waybar/config"
              #"${pkgs.eww}/bin/eww daemon"
              # "$HOME/.config/eww/scripts/eww" # When running eww as a bar
              "${pkgs.blueman}/bin/blueman-applet"
              "${pkgs.swaynotificationcenter}/bin/swaync"
              # "${pkgs.hyprpaper}/bin/hyprpaper"
            ] ++ (if hostName == "dell" then [
              "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"
              #"${pkgs.rclone}/bin/rclone mount --daemon gdrive: /GDrive --vfs-cache-mode=writes"
              # "${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse /GDrive"
            ] else [ ]);
            # env = [
            #   "XCURSOR,Catppuccin-Mocha-Dark-Cursors"
            #   "XCURSOR_SIZE,24"
            # ];
          };
        };

	};
	};
}
