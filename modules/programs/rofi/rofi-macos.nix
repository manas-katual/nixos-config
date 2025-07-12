#
#  System Menu
#
{
  config,
  lib,
  pkgs,
  userSettings,
  inputs,
  ...
}: let
  inherit (config.home-manager.users.${userSettings.username}.lib.formats.rasi) mkLiteral;
in {
  config = lib.mkIf (config.wlwm.enable && userSettings.style == "waybar-macos" || userSettings.style == "waybar-dwm") {
    home-manager.users.${userSettings.username} = {
      home = {
        packages = with pkgs; [
        ];
      };

      programs = {
        rofi = {
          enable = true;
          package = pkgs.rofi-wayland;
          extraConfig = {
            modi = "drun";
            show-icons = true;
            icon-theme = "Papirus";
            location = 0;
            font = "JetBrainsMono Nerd Font Bold 14";
            disable-history = true;
            hide-scrollbar = true;
            drun-display-format = "{icon} {name}";
            sidebar-mode = false;
            # display-drun = " 󰀘  Apps ";
            # display-run = "   Command ";
            # display-window = "   Window ";
          };
          terminal = "${pkgs.${userSettings.terminal}}/bin/${userSettings.terminal}";
          theme = {
            "*" = {
              bg0 = mkLiteral "#${config.lib.stylix.colors.base00}E6";
              bg1 = mkLiteral "#${config.lib.stylix.colors.base02}80";
              bg2 = mkLiteral "#${config.lib.stylix.colors.base0D}E6";

              fg0 = mkLiteral "#${config.lib.stylix.colors.base05}";
              fg1 = mkLiteral "#${config.lib.stylix.colors.base07}";
              fg2 = mkLiteral "#${config.lib.stylix.colors.base05}80";

              background-color = mkLiteral "transparent";
              text-color = mkLiteral "@fg0";
              margin = mkLiteral "0";
              padding = mkLiteral "0";
              spacing = mkLiteral "0";
            };

            "window" = {
              background-color = mkLiteral "@bg0";
              location = mkLiteral "center";
              width = mkLiteral "640px";
              border-radius = mkLiteral "8px";
            };

            "inputbar" = {
              padding = mkLiteral "12px";
              spacing = mkLiteral "12px";
              children = map mkLiteral ["icon-search" "entry"];
            };

            "icon-search" = {
              expand = false;
              filename = "search";
              size = mkLiteral "28px";
              vertical-align = mkLiteral "0.5";
            };

            "entry" = {
              font = mkLiteral "inherit";
              placeholder = "Search";
              placeholder-color = mkLiteral "@fg2";
              vertical-align = mkLiteral "0.5";
            };

            "message" = {
              border = mkLiteral "2px 0 0";
              border-color = mkLiteral "@bg1";
              background-color = mkLiteral "@bg1";
            };

            "textbox" = {
              padding = mkLiteral "8px 24px";
            };

            "listview" = {
              lines = 10;
              columns = 1;
              fixed-height = false;
              border = mkLiteral "1px 0 0";
              border-color = mkLiteral "@bg1";
            };

            "element" = {
              padding = mkLiteral "8px 16px";
              spacing = mkLiteral "16px";
              background-color = mkLiteral "transparent";
              text-color = mkLiteral "@fg0";
            };

            "element normal active" = {
              text-color = mkLiteral "@bg2";
            };

            "element alternate active" = {
              text-color = mkLiteral "@bg2";
            };

            "element selected normal" = {
              background-color = mkLiteral "@bg2";
              text-color = mkLiteral "@fg1";
            };

            "element selected active" = {
              background-color = mkLiteral "@bg2";
              text-color = mkLiteral "@fg1";
            };

            "element-icon" = {
              size = mkLiteral "1em";
              vertical-align = mkLiteral "0.5";
            };

            "element-text" = {
              text-color = mkLiteral "inherit";
              vertical-align = mkLiteral "0.5";
            };
          };
        };
      };
    };
  };
}
