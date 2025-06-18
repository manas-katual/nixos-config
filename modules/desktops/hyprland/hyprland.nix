#
#  Hyprland Configuration
#  Enable with "hyprland.enable = true;"
#
#  useful commands for nix
#  find $(nix eval --raw nixpkgs#hyprpolkitagent) -type f -name 'hyprpolkitagent'
#  ls -l $(nix eval --raw nixpkgs#pyprland)/bin/
#
{
  config,
  lib,
  pkgs,
  userSettings,
  host,
  inputs,
  ...
}:
with lib;
with host; {
  config = mkIf (config.hyprland.enable) {
    wlwm.enable = true;

    environment = let
      exec = "exec dbus-launch Hyprland";
    in {
      loginShellInit = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
          ${exec}
        fi
      '';

      systemPackages = with pkgs;
        [
          hyprcursor # Cursor
          wl-clipboard # Clipboard
          wlr-randr # Monitor Settings
          xwayland # X session
          hyprpolkitagent
        ]
        ++ (
          if (userSettings.style == "waybar-oglo" || userSettings.style == "waybar-curve")
          then [
            pkgs.blueman
          ]
          else []
        );
    };

    services.blueman.enable =
      if userSettings.style == "waybar-oglo" || userSettings.style == "waybar-curve"
      then true
      else false;

    programs.light.enable = true;

    programs.hyprland = {
      enable = true;
    };

    home-manager.users.${userSettings.username} = {
      systemd.user.targets.hyprland-session.Unit.Wants = [
        "xdg-desktop-autostart.target"
      ];
      wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        xwayland.enable = true;
        systemd = {
          enable = true;
          enableXdgAutostart = true;
          variables = ["--all"];
        };
        settings = {
          env = [
            "NIXOS_OZONE_WL, 1"
            "NIXPKGS_ALLOW_UNFREE, 1"
            "XDG_CURRENT_DESKTOP, Hyprland"
            "XDG_SESSION_TYPE, wayland"
            "XDG_SESSION_DESKTOP, Hyprland"
            "GDK_BACKEND, wayland, x11"
            "CLUTTER_BACKEND, wayland"
            "QT_QPA_PLATFORM=wayland;xcb"
            "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
            "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
            "SDL_VIDEODRIVER, x11"
            "MOZ_ENABLE_WAYLAND, 1"
            "GDK_SCALE,1"
            "QT_SCALE_FACTOR,1"
            "EDITOR,nvim"
          ];

          exec-once =
            [
              "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
              "pgrep -x hyprpolkitagent || ${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent &"
              "${pkgs.hyprlock}/bin/hyprlock"
              "${pkgs.hypridle}/bin/hypridle"
              # "ln -s $XDG_RUNTIME_DIR/hypr /tmp/hypr"
              "pypr &"
            ]
            ++ (
              if userSettings.style == "waybar-oglo" || userSettings.style == "waybar-curve"
              then [
                "pgrep -x waybar || ${pkgs.waybar}/bin/waybar &"
                "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"
                "${pkgs.blueman}/bin/blueman-applet"
                "${pkgs.eww}/bin/eww daemon"
                # "$HOME/.config/eww/scripts/eww" # When running eww as a bar
                "${pkgs.swaynotificationcenter}/bin/swaync"
              ]
              else if userSettings.style == "hyprpanel"
              then [
                "${inputs.hyprpanel.packages.${pkgs.system}.wrapper}/bin/hyprpanel"
              ]
              else if userSettings.style == "ags"
              then [
                "ags run --gtk4"
              ]
              else []
            );

          general = {
            "$modifier" = "SUPER";
            border_size = 4;
            gaps_in = 10;
            gaps_out = 20;
            "col.active_border" = lib.mkDefault "0x99${config.lib.stylix.colors.base0D}";
            "col.inactive_border" = lib.mkDefault "0x66${config.lib.stylix.colors.base02}";
            resize_on_border = true;
            hover_icon_on_border = false;
            layout = "dwindle";
          };
          decoration = {
            rounding = 4;
            active_opacity = 1;
            inactive_opacity = 1;
            fullscreen_opacity = 1;
            blur = {
              enabled = true;
              size = 2;
              passes = 3;
              special = false;
              new_optimizations = true;
            };
          };
          monitor =
            if (hostName == "dell")
            then "HDMI-A-1,1366x768,auto,1,mirror,LVDS-1"
            else if (hostName == "hp")
            then "HDMI-A-1,1366x768,auto,1,mirror,LVDS-1"
            else if (hostName == "nokia")
            then "eDP-1,1920x1080@60,0x0,1"
            else ",preferred,auto,auto";
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
            # kb_variant = "eng";
            kb_options = [
              "grp:alt_caps_toggle"
              "caps:super"
            ];
            follow_mouse = 1;
            repeat_delay = 250;
            numlock_by_default = 1;
            accel_profile = "flat";
            sensitivity = 0.8;
            natural_scroll = false;
            touchpad =
              if hostName == "dell" || hostName == "nokia" || hostName == "hp"
              then {
                natural_scroll = true;
                scroll_factor = 0.2;
                middle_button_emulation = true;
                tap-to-click = true;
              }
              else {};
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
            if hostName == "dell" || hostName == "nokia" || hostName == "hp"
            then {
              workspace_swipe = true;
              workspace_swipe_fingers = 3;
              workspace_swipe_distance = 100;
              workspace_swipe_create_new = true;
            }
            else {};
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
        };
      };
    };
  };
}
