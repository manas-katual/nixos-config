#
#  System Menu
#
{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}: let
  inherit (config.home-manager.users.${userSettings.username}.lib.formats.rasi) mkLiteral;
in {
  config = lib.mkIf (config.wlwm.enable && userSettings.style == "waybar-curve") {
    home-manager.users.${userSettings.username} = {
      home = {
        packages = with pkgs; [
          # rofi-power-menu
        ];
      };

      programs = {
        rofi = {
          enable = true;
          package = pkgs.rofi-wayland;
          extraConfig = {
            modi = "drun,run";
            show-icons = true;
            icon-theme = "Papirus";
            location = 0;
            font = "JetBrainsMono Nerd Font Bold 14";
            disable-history = false;
            hide-scrollbar = true;
            drun-display-format = "{icon} {name}";
            sidebar-mode = true;
            display-drun = " 󰀘  Apps ";
            display-run = "   Command ";
            display-window = "   Window ";
          };
          terminal = "${pkgs.${userSettings.terminal}}/bin/${userSettings.terminal}";
          theme = {
            "*" = {
              bg = mkLiteral "#${config.lib.stylix.colors.base00}";
              bg-alt = mkLiteral "#${config.lib.stylix.colors.base09}";
              foreground = mkLiteral "#${config.lib.stylix.colors.base01}";
              selected = mkLiteral "#${config.lib.stylix.colors.base08}";
              active = mkLiteral "#${config.lib.stylix.colors.base0B}";
              text-selected = mkLiteral "#${config.lib.stylix.colors.base00}";
              text-color = mkLiteral "#${config.lib.stylix.colors.base05}";
              border-color = mkLiteral "#${config.lib.stylix.colors.base0F}";
              urgent = mkLiteral "#${config.lib.stylix.colors.base0E}";
            };
            "window" = {
              transparency = "real";
              width = mkLiteral "1000px";
              location = mkLiteral "center";
              anchor = mkLiteral "center";
              fullscreen = false;
              x-offset = mkLiteral "0px";
              y-offset = mkLiteral "0px";
              cursor = "default";
              enabled = true;
              border-radius = mkLiteral "15px";
              background-color = mkLiteral "@bg";
            };
            "mainbox" = {
              enabled = true;
              spacing = mkLiteral "0px";
              orientation = mkLiteral "horizontal";
              children = map mkLiteral [
                "imagebox"
                "listbox"
              ];
              background-color = mkLiteral "transparent";
            };
            "imagebox" = {
              padding = mkLiteral "20px";
              background-color = mkLiteral "transparent";
              background-image = mkLiteral ''url("~/Pictures/Wallpapers/linux.png", height)'';
              orientation = mkLiteral "vertical";
              children = map mkLiteral [
                "inputbar"
                "dummy"
                "mode-switcher"
              ];
            };
            "listbox" = {
              spacing = mkLiteral "20px";
              padding = mkLiteral "20px";
              background-color = mkLiteral "transparent";
              orientation = mkLiteral "vertical";
              children = map mkLiteral [
                "message"
                "listview"
              ];
            };
            "dummy" = {
              background-color = mkLiteral "transparent";
            };
            "inputbar" = {
              enabled = true;
              spacing = mkLiteral "10px";
              padding = mkLiteral "10px";
              border-radius = mkLiteral "10px";
              background-color = mkLiteral "@bg-alt";
              text-color = mkLiteral "@foreground";
              children = map mkLiteral [
                "textbox-prompt-colon"
                "entry"
              ];
            };
            "textbox-prompt-colon" = {
              enabled = true;
              expand = false;
              str = " ";
              background-color = mkLiteral "inherit";
              text-color = mkLiteral "inherit";
            };
            "entry" = {
              enabled = true;
              background-color = mkLiteral "inherit";
              text-color = mkLiteral "inherit";
              cursor = mkLiteral "text";
              placeholder = "Search";
              placeholder-color = mkLiteral "inherit";
            };
            "mode-switcher" = {
              enabled = true;
              spacing = mkLiteral "20px";
              background-color = mkLiteral "transparent";
              text-color = mkLiteral "@foreground";
            };
            "button" = {
              padding = mkLiteral "15px";
              border-radius = mkLiteral "10px";
              background-color = mkLiteral "@bg-alt";
              text-color = mkLiteral "inherit";
              cursor = mkLiteral "pointer";
            };
            "button selected" = {
              background-color = mkLiteral "@selected";
              text-color = mkLiteral "@foreground";
            };
            "listview" = {
              enabled = true;
              columns = 1;
              lines = 8;
              cycle = true;
              dynamic = true;
              scrollbar = false;
              layout = mkLiteral "vertical";
              reverse = false;
              fixed-height = true;
              fixed-columns = true;
              spacing = mkLiteral "10px";
              background-color = mkLiteral "transparent";
              text-color = mkLiteral "@foreground";
              cursor = "default";
            };
            "element" = {
              enabled = true;
              spacing = mkLiteral "15px";
              padding = mkLiteral "8px";
              border-radius = mkLiteral "10px";
              background-color = mkLiteral "transparent";
              text-color = mkLiteral "@text-color";
              cursor = mkLiteral "pointer";
            };
            "element normal.normal" = {
              background-color = mkLiteral "inherit";
              text-color = mkLiteral "@text-color";
            };
            "element normal.urgent" = {
              background-color = mkLiteral "@urgent";
              text-color = mkLiteral "@text-color";
            };
            "element normal.active" = {
              background-color = mkLiteral "inherit";
              text-color = mkLiteral "@text-color";
            };
            "element selected.normal" = {
              background-color = mkLiteral "@selected";
              text-color = mkLiteral "@foreground";
            };
            "element selected.urgent" = {
              background-color = mkLiteral "@urgent";
              text-color = mkLiteral "@text-selected";
            };
            "element selected.active" = {
              background-color = mkLiteral "@urgent";
              text-color = mkLiteral "@text-selected";
            };
            "element-icon" = {
              background-color = mkLiteral "transparent";
              text-color = mkLiteral "inherit";
              size = mkLiteral "36px";
              cursor = mkLiteral "inherit";
            };
            "element-text" = {
              background-color = mkLiteral "transparent";
              text-color = mkLiteral "inherit";
              cursor = mkLiteral "inherit";
              vertical-align = mkLiteral "0.5";
              horizontal-align = mkLiteral "0.0";
            };
            "message" = {
              background-color = mkLiteral "transparent";
            };
            "textbox" = {
              padding = mkLiteral "15px";
              border-radius = mkLiteral "10px";
              background-color = mkLiteral "@bg-alt";
              text-color = mkLiteral "@foreground";
              vertical-align = mkLiteral "0.5";
              horizontal-align = mkLiteral "0.0";
            };
            "error-message" = {
              padding = mkLiteral "15px";
              border-radius = mkLiteral "20px";
              background-color = mkLiteral "@bg";
              text-color = mkLiteral "@foreground";
            };
          };
        };
      };
    };
  };
}
