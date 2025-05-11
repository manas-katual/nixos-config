{ config, pkgs, userSettings, lib, host, inputs, ...}:

with lib;
with host;
{
  options = {
    niri = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.niri.enable) {
    wlwm.enable = true;

    environment = {
      variables = {
      };
      systemPackages = with pkgs; [
        wev # Event Viewer
        wl-clipboard # Clipboard
        wlr-randr # Monitor Settings
        xdg-desktop-portal-wlr # Wayland portal
        xwayland # X for Wayland
        networkmanagerapplet
      ];
    };

    services.greetd = {                                   
      enable = true;                                      
      settings = {                                        
        default_session = {                               
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session";
          user = "${userSettings.username}";              
        };                                                
      };                                                  
    };

    programs = {
      light = {
        enable = true;
      };
    };

    home-manager.users.${userSettings.username} = ({config, ... }: 
      let
        makeCommand = command: {
          command = [command];
        };

        Modifier = "Mod";
        Menu = "${pkgs.rofi-wayland}/bin/rofi";
      in {
        imports = [ inputs.niri.homeModules.niri ];

        services.hyprpaper = {
          enable = true;
          settings = {
            ipc = true;
            splash = false;
            preload = [ ''+config.stylix.image+'' ];
            wallpaper = [ ''+config.stylix.image+'' ];
          };
        };

        programs.niri = {
          enable = true;
          package = pkgs.niri;
          settings = {
            environment = {
              CLUTTER_BACKEND = "wayland";
              DISPLAY = null;
              GDK_BACKEND = "wayland,x11";
              MOZ_ENABLE_WAYLAND = "1";
              NIXOS_OZONE_WL = "1";
              QT_QPA_PLATFORM = "wayland;xcb";
              QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
              SDL_VIDEODRIVER = "wayland";
            };
            spawn-at-startup = [
              (makeCommand "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1")
              (makeCommand "${pkgs.waybar}/bin/waybar")
              (makeCommand "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator")
              (makeCommand "${pkgs.blueman}/bin/blueman-applet")
              (makeCommand "${pkgs.swaynotificationcenter}/bin/swaync")
            ];

            input = {
              keyboard.xkb = {
                layout = "us";
                options = "numpad:pc";
              };
              touchpad = {
                click-method = "button-areas";
                dwt = true;
                dwtp = true;
                natural-scroll = true;
                scroll-method = "two-finger";
                tap = true;
                tap-button-map = "left-right-middle";
                middle-emulation = true;
                accel-profile = "adaptive";
                # scroll-factor = 0.2;
              };
              focus-follows-mouse.enable = true;
              warp-mouse-to-focus = true;
              workspace-auto-back-and-forth = true;
            };
            
            screenshot-path = "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png";

            prefer-no-csd = true;

            layout = {
              focus-ring.enable = false;
              border = {
                enable = true;
                width = 1;
                active.color = "#${config.lib.stylix.colors.base0B}";
                inactive.color = "#${config.lib.stylix.colors.base00}";
              };
              shadow = {
                enable = true;
              };
              preset-column-widths = [
                {proportion = 0.25;}
                {proportion = 0.5;}
                {proportion = 0.75;}
                {proportion = 1.0;}
              ];
              default-column-width = {proportion = 0.5;};

              gaps = 6;
              struts = {
                left = 0;
                right = 0;
                top = 0;
                bottom = 0;
              };

              tab-indicator = {
                hide-when-single-tab = true;
                place-within-column = true;
                position = "left";
                corner-radius = 20.0;
                gap = -12.0;
                gaps-between-tabs = 10.0;
                width = 4.0;
                length.total-proportion = 0.1;
              };
            };
            binds = with config.lib.niri.actions;
              let
                set-volume = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@";
                brillo = spawn "${pkgs.brillo}/bin/brillo" "-q" "-u" "300000";
              in {
                "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
                "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

                "XF86AudioRaiseVolume".action = set-volume "5%+";
                "XF86AudioLowerVolume".action = set-volume "5%-";

                "XF86MonBrightnessUp".action = brillo "-A" "5";
                "XF86MonBrightnessDown".action = brillo "-U" "5";

                "Print".action.screenshot-screen = {write-to-disk = true;};
                "${Modifier}+Shift+Alt+S".action = screenshot-window;
                "${Modifier}+Shift+S".action = screenshot;

                "${Modifier}+Return".action = spawn "${pkgs.${userSettings.terminal}}/bin/${userSettings.terminal}";
                "${Modifier}+Space".action = spawn "${Menu}" "-show" "drun";
                "${Modifier}+Escape".action.quit.skip-confirmation = false;

                "${Modifier}+1".action.focus-workspace = 1;
                "${Modifier}+2".action.focus-workspace = 2;
                "${Modifier}+3".action.focus-workspace = 3;
                "${Modifier}+4".action.focus-workspace = 4;
                
                "${Modifier}+Minus".action = set-column-width "-10%";
                "${Modifier}+Plus".action = set-column-width "+10%";
                "${Modifier}+Shift+Minus".action = set-window-height "-10%";
                "${Modifier}+Shift+Plus".action = set-window-height "+10%";

                "${Modifier}+Comma".action = consume-window-into-column;
                "${Modifier}+Period".action = expel-window-from-column;
                "${Modifier}+C".action = center-window;
                "${Modifier}+Tab".action = switch-focus-between-floating-and-tiling;

                "${Modifier}+Q".action = close-window;
                "${Modifier}+F".action = toggle-window-floating;
                "${Modifier}+S".action = switch-preset-column-width;
                "${Modifier}+Shift+F".action = expand-column-to-available-width;
                "${Modifier}+W".action = toggle-column-tabbed-display;

                "${Modifier}+Left".action = focus-column-left;
                "${Modifier}+Up".action = focus-workspace-up;
                "${Modifier}+Right".action = focus-column-right;
                "${Modifier}+Down".action = focus-workspace-down;

                "${Modifier}+Shift+H".action = move-column-left;
                "${Modifier}+Shift+L".action = move-column-right;
                "${Modifier}+Shift+K".action = move-column-to-workspace-up;
                "${Modifier}+Shift+J".action = move-column-to-workspace-down;
              };
          };
        }; 
    });
  };
}
