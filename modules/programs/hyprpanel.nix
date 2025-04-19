{ pkgs, config, lib, hyprpanel, inputs, userSettings, ...}:

{

  config = lib.mkIf (config.wlwm.enable && userSettings.bar == "hyprpanel") {
    environment.systemPackages = [
      pkgs.libgtop
      pkgs.ags
    ];

    home-manager.users.${userSettings.username} = 
      # {
      # imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];
      #
      # programs.hyprpanel = {
      #   enable = true;
      #   systemd.enable = true;
      #   hyprland.enable = true;
      #   overwrite.enable = true;
      #   theme = "one_dark";
      #   override = {
      #     theme.bar.menus.text = "#123ABC";
      #   };
      #   layout = {
      #     "bar.layouts" = {
      #       "0" = {
      #         left = [ "dashboard" "workspaces" "windowtitle" ];
      #         middle = [ "clock" ];
      #         right = [ "hypridle" "battery" "volume" "network" "bluetooth"  "notifications" "systray" ];
      #       };
      #     };
      #   };
      #   settings = {
      #     bar = {
      #       launcher = {
      #         autoDetectIcon = true;
      #       };
      #       workspaces = {
      #         show_icons = false;
      #         showWsIcons = false;
      #         reverse_scroll = true;
      #       };
      #       battery = {
      #         label = true;
      #       };
      #       bluetooth = {
      #         label = false;
      #       };
      #       network = {
      #         label = false;
      #       };
      #       clock = {
      #         icon = "󱑏";
      #         format = "%I:%M %p";
      #         #rightClick = '' hyprpanel set clock.format "%a %b %d %I:%M %p" '';
      #       };
      #       customModules = {
      #         hypridle = {
      #           label = false;
      #           onIcon = "󰅶";
      #           offIcon = "󰾪";
      #         };
      #       };
      #     };
      #     theme = {
      #       bar = {
      #         floating = true;
      #         #border_radius = "0.9em";
      #         transparent = false;
      #       };
      #       font = {
      #         name = "CaskaydiaCove NF";
      #         size = "13px";
      #       };
      #       # matugen = true;
      #       # matugen_settings = {
      #       #   mode = "dark";
      #       #   scheme_type = "expressive";
      #       #   variation = "standard_1";
      #       # };
      #     };
      #
      #     menus = {
      #       clock = {
      #         time = {
      #           military = true;
      #           hideSeconds = true;
      #         };
      #         weather.unit = "metric";
      #       };
      #       dashboard = {
      #         directories = {
      #           enabled = false;
      #         };
      #         stats = {
      #           enable_gpu = true;
      #         };
      #       };
      #     };
      #     # wallpaper = {
      #     #   enable = true;
      #     #   image = "../wallpapers/streetlight.jpg";
      #     # };
      #   };
      # };


let
  accent = "#${config.lib.stylix.colors.base0D}";
  accent-alt = "#${config.lib.stylix.colors.base03}";
  background = "#${config.lib.stylix.colors.base00}";
  background-alt = "#${config.lib.stylix.colors.base01}";
  foreground = "#${config.lib.stylix.colors.base05}";
  rounding = 18;
in
{
  imports = [
    inputs.hyprpanel.homeManagerModules.hyprpanel
  ];

  programs.hyprpanel = {
    overlay.enable = true;
    enable = true;
    hyprland.enable = true;
    overwrite.enable = true;
    layout = {
      "bar.layouts" = {
        "0" = {
          "left" = [
            "dashboard"
            "workspaces"
            "windowtitle"
          ];
          "middle" = [
            "clock"
            "media"
          ];
          "right" = [
            "hypridle"
            "battery"
            "volume"
            "bluetooth"
            "network"
            "systray"
            "notifications"
          ];
        };

      };
    };

    override = {
      "tear" = true; # Screen Tearing
      "theme.font.size" = "0.8rem";
      "theme.bar.outer_spacing" = "1rem";
      "theme.bar.dropdownGap" = "3.3em";
      "scalingPriority" = "hyprland";
      "bar.launcher.icon" = "";

      "bar.workspaces.showAllActive" = false;
      "bar.workspaces.workspaces" = 1;
      "bar.workspaces.monitorSpecific" = false;
      "bar.workspaces.hideUnoccupied" = true;
      "bar.workspaces.showApplicationIcons" = true;
      "bar.workspaces.showWsIcons" = true;
      "bar.workspaces.ignored" = "98";

      "bar.windowtitle.label" = false;
      "bar.clock.format" = "%b %d  %k:%M";
      "bar.clock.showIcon" = false;
      "bar.volume.label" = true;
      "bar.bluetooth.label" = false;
      "bar.network.label" = false;
      "bar.media.show_active_only" = true;
      "menus.clock.weather.enable" = false;

      "theme.bar.menus.monochrome" = true;
      "theme.bar.buttons.monochrome" = true;
      "wallpaper.enable" = false;

      "theme.bar.buttons.workspaces.hover" = "${accent-alt}";
      "theme.bar.buttons.workspaces.active" = "${accent}";
      "theme.bar.buttons.workspaces.available" = "${accent-alt}";
      "theme.bar.buttons.workspaces.occupied" = "${accent-alt}";
      "theme.bar.menus.background" = "${background}";
      "theme.bar.menus.cards" = "${background-alt}";
      "theme.bar.menus.card_radius" = "${toString rounding}px";
      "theme.bar.menus.label" = "${foreground}";
      "theme.bar.menus.text" = "${foreground}";
      "theme.bar.menus.border.color" = "${accent}";
      "theme.bar.menus.border.radius" = "${toString rounding}px";
      "theme.bar.menus.popover.text" = "${foreground}";
      "theme.bar.menus.popover.background" = "${background-alt}";
      "theme.bar.menus.listitems.active" = "${accent}";
      "theme.bar.menus.icons.active" = "${accent}";
      "theme.bar.menus.switch.enabled" = "${accent}";
      "theme.bar.menus.check_radio_button.active" = "${accent}";
      "theme.bar.menus.buttons.default" = "${accent}";
      "theme.bar.menus.buttons.active" = "${accent}";
      "theme.notification.border_radius" = "${toString rounding}px";
      "theme.bar.menus.iconbuttons.active" = "${accent}";
      "theme.bar.menus.progressbar.foreground" = "${accent}";
      "theme.bar.menus.slider.primary" = "${accent}";
      "theme.bar.menus.tooltip.background" = "${background-alt}";
      "theme.bar.menus.tooltip.text" = "${foreground}";
      "theme.bar.menus.dropdownmenu.background" = "${background-alt}";
      "theme.bar.menus.dropdownmenu.text" = "${foreground}";
      "theme.bar.background" = "${background}";
      "theme.bar.buttons.text" = "${foreground}";
      "theme.bar.buttons.radius" = "${toString rounding}px";
      "theme.bar.buttons.background" = "${background-alt}";
      "theme.bar.buttons.icon" = "${accent}";
      "theme.bar.buttons.notifications.background" = "${background-alt}";
      "theme.bar.buttons.hover" = "${background}";
      "theme.bar.buttons.notifications.hover" = "${background}";
      "theme.bar.buttons.notifications.total" = "${accent}";
      "theme.bar.buttons.notifications.icon" = "${accent}";
      "theme.notification.background" = "${background-alt}";
      "theme.notification.actions.background" = "${accent}";
      "theme.notification.actions.text" = "${foreground}";
      "theme.notification.label" = "${accent}";
      "theme.notification.border" = "${background-alt}";
      "theme.notification.text" = "${foreground}";
      "theme.notification.labelicon" = "${accent}";
      "theme.osd.bar_color" = "${accent}";
      "theme.osd.bar_overflow_color" = "${accent-alt}";
      "theme.osd.icon" = "${background}";
      "theme.osd.icon_container" = "${accent}";
      "theme.osd.label" = "${accent}";
      "theme.osd.bar_container" = "${background-alt}";
      "theme.bar.menus.menu.media.background.color" = "${background-alt}";
      "theme.bar.menus.menu.media.card.color" = "${background-alt}";
      "theme.bar.menus.menu.media.card.tint" = 90;
      "bar.customModules.updates.pollingInterval" = 1440000;
    };
  };
};

    # };
  };
}
