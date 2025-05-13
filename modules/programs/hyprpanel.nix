{ pkgs, config, lib, hyprpanel, inputs, userSettings, ...}:

{

  config = lib.mkIf (config.wlwm.enable && userSettings.bar == "hyprpanel") {
    environment.systemPackages = [
      # pkgs.libgtop
      # pkgs.ags
      pkgs.hyprpanel
    ];

    nixpkgs.overlays = [ inputs.hyprpanel.overlay ];

    home-manager.users.${userSettings.username} = 
      let
        accent = "#${config.lib.stylix.colors.base0D}";
        accent-alt = "#${config.lib.stylix.colors.base03}";
        background = "#${config.lib.stylix.colors.base00}";
        background-alt = "#${config.lib.stylix.colors.base01}";
        foreground = "#${config.lib.stylix.colors.base05}";
        rounding = 10;
      in {
        imports = [
          inputs.hyprpanel.homeManagerModules.hyprpanel
        ];

        programs.hyprpanel = {
          overlay.enable = true;
          enable = true;
          hyprland.enable = true;
          overwrite.enable = true;
          settings = { 
            layout = {
              "bar.layouts" = {
                "0" = {
                  "left" = [
                    "workspaces"
                    "windowtitle"
                  ];
                  "middle" = [ ];
                  "right" = [
                    "systray"
                    "hypridle"
                    "battery"
                    "volume"
                    "bluetooth"
                    "network"
                    "clock"
                    "notifications"
                    "dashboard"
                  ];
                };
              };
            };
          };

          override = {
            "tear" = true; # Screen Tearing
            "theme.font.size" = "0.8rem";
            "theme.bar.outer_spacing" = "1rem";
            "theme.bar.dropdownGap" = "3.3em";
            "scalingPriority" = "hyprland";
            "bar.launcher.icon" = "󰍜"; #"";

            "bar.workspaces.showAllActive" = false;
            "bar.workspaces.workspaces" = 1;
            "bar.workspaces.monitorSpecific" = false;
            "bar.workspaces.hideUnoccupied" = true;
            # "bar.workspaces.showApplicationIcons" = true;
            # "bar.workspaces.showWsIcons" = true;
            "bar.workspaces.show_icons" = true;
            "bar.workspaces.show_numbered" = false;
            "bar.workspaces.reverse_scroll" = true;
            "bar.workspaces.ignored" = "98";

            "bar.windowtitle.label" = false;
            "bar.clock.format" = "%I:%M %p";
            "bar.clock.showIcon" = true;
            "bar.clock.icon" = "󱑏";
            "bar.volume.label" = true;
            "bar.bluetooth.label" = false;
            "bar.network.label" = false;
            "bar.media.show_active_only" = true;

            "bar.customModules.hypridle.label" = false;
            "bar.customModules.hypridle.onIcon" = "󰅶";
            "bar.customModules.hypridle.offIcon" = "󰾪";
            
            "menus.clock.weather.enable" = false;
            "menus.clock.time.military" = true;
            "menus.clock.time.hideSeconds" = true;
            "menus.dashboard.directories.enabled" = false;
            "menus.dashboard.shortcuts.enabled" = false;
            "menus.dashboard.powermenu.avatar.image" = "/home/manas/setup/modules/programs/icons/nixos.png";

            "theme.bar.buttons.opacity" = 100;
            "theme.bar.menus.monochrome" = true;
            "theme.bar.buttons.monochrome" = true;
            "theme.bar.buttons.workspaces.enableBorder" = false;
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
  };
}
