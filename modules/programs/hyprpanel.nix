{ pkgs, config, hyprpanel, inputs, userSettings, ...}:

{

  environment.systemPackages = [
    pkgs.libgtop
    pkgs.ags
  ];

  home-manager.users.${userSettings.username} = {
    imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

    programs.hyprpanel = {
      enable = true;
      systemd.enable = true;
      hyprland.enable = true;
      overwrite.enable = true;
      theme = "one_dark";
      override = {
        theme.bar.menus.text = "#123ABC";
      };
      layout = {
        "bar.layouts" = {
          "0" = {
            left = [ "dashboard" "workspaces" "windowtitle" ];
            middle = [ "clock" ];
            right = [ "hypridle" "battery" "volume" "network" "bluetooth"  "notifications" "systray" ];
          };
        };
      };
      settings = {
        bar = {
          launcher = {
            autoDetectIcon = true;
          };
          workspaces = {
            show_icons = false;
            showWsIcons = false;
            reverse_scroll = true;
          };
          battery = {
            label = true;
          };
          bluetooth = {
            label = false;
          };
          network = {
            label = false;
          };
          clock = {
            icon = "󱑏";
            format = "%I:%M %p";
            #rightClick = '' hyprpanel set clock.format "%a %b %d %I:%M %p" '';
          };
          customModules = {
            hypridle = {
              label = false;
            };
          };
        };
        theme = {
          bar = {
            floating = true;
            #border_radius = "0.9em";
            transparent = false;
          };
          font = {
            name = "CaskaydiaCove NF";
            size = "13px";
          };
          # matugen = true;
          # matugen_settings = {
          #   mode = "dark";
          #   scheme_type = "expressive";
          #   variation = "standard_1";
          # };
        };

        menus = {
          clock = {
            time = {
              military = true;
              hideSeconds = true;
            };
            weather.unit = "metric";
          };
          dashboard = {
            directories = {
              enabled = false;
            };
            stats = {
              enable_gpu = true;
            };
          };
        };
        # wallpaper = {
        #   enable = true;
        #   image = "../wallpapers/streetlight.jpg";
        # };
      };
    };

  };
}
