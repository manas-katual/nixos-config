{ config, hyprpanel, inputs, userSettings, ...}:

{
  home-manager.users.${userSettings.username} = {
    imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    hyprland.enable = true;
    overwrite.enable = true;
    theme = "gruvbox";
    override = {
      theme.bar.menus.text = "#123ABC";
    };
    layout = {
      "bar.layouts" = {
        "0" = {
          left = [ "dashboard" "workspaces" "windowtitle" ];
          middle = [ "clock" ];
          right = [ "battery" "volume" "network" "bluetooth" "systray" "notifications" "power" ];
        };
      };
    };
    settings = {
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;
      theme.bar.floating = true;
      bar.battery.label = true;

      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      theme.bar.transparent = false;

      theme.font = {
        name = "CaskaydiaCove NF";
        size = "13px";
      };
    };
    };

  };
}
