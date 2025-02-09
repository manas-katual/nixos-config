#
#  System Menu
#

{ config, lib, pkgs, userSettings, ... }:

let
  inherit (config.home-manager.users.${userSettings.username}.lib.formats.rasi) mkLiteral;
  #colors = import ../theming/colors.nix;
in
{
  config = lib.mkIf (config.wlwm.enable) {
    home-manager.users.${userSettings.username} = {
      home = {
        packages = with pkgs; [
          rofi-power-menu
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
          # location = "center";
          # font = lib.mkForce "FiraCode Nerd Font Mono 11";
          theme = 
            # let 
            #   inherit (config.lib.formats.rasi) mkLiteral;
            # in 
            {
            "*" = lib.mkForce {
              # normal-text = "#ffffff";
              # separatorcolor = "#ffffff";
              # bg-col = mkLiteral "#${config.lib.stylix.colors.base00}";
              # bg-col-transparent = mkLiteral "#${config.lib.stylix.colors.base00}dd";
              # bg-col-element = mkLiteral "#${config.lib.stylix.colors.base00}df";
              # bg-col-light = mkLiteral "#${config.lib.stylix.colors.base0B}";
              # border-color = mkLiteral "#${config.lib.stylix.colors.base0B}";
              # selected-col = mkLiteral "#${config.lib.stylix.colors.base0B}";
              # tab = mkLiteral "#${config.lib.stylix.colors.base0B}";
              # tab-selected = mkLiteral "#${config.lib.stylix.colors.base00}";
              # fg-col = mkLiteral "#${config.lib.stylix.colors.base0E}";
              # fg-col2 = mkLiteral "#${config.lib.stylix.colors.base00}";
              # blank = mkLiteral "#${config.lib.stylix.colors.base00}";
              # blank-underline = mkLiteral "#${config.lib.stylix.colors.base00}";
              # button = mkLiteral "#${config.lib.stylix.colors.base0B}";
              # button-underline = mkLiteral "#${config.lib.stylix.colors.base0B}";
              # window = mkLiteral "#${config.lib.stylix.colors.base02}";
              # window-underline = mkLiteral "#${config.lib.stylix.colors.base01}";


              # bg-alt = mkLiteral "#${config.lib.stylix.colors.base09}";
              # foreground = mkLiteral "#${config.lib.stylix.colors.base01}";
              # selected = mkLiteral "#${config.lib.stylix.colors.base08}";
              # active = mkLiteral "#${config.lib.stylix.colors.base0B}";
              # text-selected = mkLiteral "#${config.lib.stylix.colors.base00}";
              # text-color = mkLiteral "#${config.lib.stylix.colors.base05}";
              # urgent = mkLiteral "#${config.lib.stylix.colors.base0E}";

              bg-col = mkLiteral "#1d2021";
              bg-col-transparent = mkLiteral "#1d2021dd";
              bg-col-element = mkLiteral "#1d2021df";
              bg-col-light = mkLiteral "#689d6a";
              border-col = mkLiteral "#689d6a";
              selected-col = mkLiteral "#689d6a";
              tab = mkLiteral "#689d6a";
              tab-selected = mkLiteral "#1d2021";
              fg-col = mkLiteral "#ebdbb2";
              fg-col2 = mkLiteral "#1d2021";
              blank = mkLiteral "#1f2223";
              blank-underline = mkLiteral "#191c1d";
              button = mkLiteral "#689d6a";
              button-underline = mkLiteral "#518554";
              window = mkLiteral "#303030";
              window-underline = mkLiteral "#272727";

            };
            "element-text" = lib.mkForce {
              background-color = mkLiteral "#00000000";
              text-color = mkLiteral "inherit";
            };
            "element-text selected" = lib.mkForce {
              background-color = mkLiteral "#00000000";
              text-color = mkLiteral "inherit";
            };
            "mode-switcher" = lib.mkForce {
              enabled = true;
              spacing = mkLiteral "0px";
              background-color = mkLiteral "#00000000";
            };
            "window" = lib.mkForce {
                height = mkLiteral "400px";
                width = mkLiteral "600px";
                border-radius = mkLiteral "10px";
                border = mkLiteral "0px 0px 8px 0px";
                border-color = mkLiteral "@window-underline";
                background-color = mkLiteral "@window";
                padding = mkLiteral "4px 8px 4px 8px";
                fullscreen = false;
            };

            "mainbox" = lib.mkForce {
                background-color= mkLiteral "#00000000";
            };

            "inputbar" = lib.mkForce {
                children = map mkLiteral [
                  "prompt"
                  "entry"
                ];
                background-color = mkLiteral "#00000000";
                border-radius = mkLiteral "5px";
                padding = mkLiteral "2px";
                margin = mkLiteral "0px -5px -4px -5px";
            };

            "prompt" = lib.mkForce {
                background-color = mkLiteral "@button";
                padding = mkLiteral "12px";
                text-color = mkLiteral "@bg-col";
                border-radius = mkLiteral "5px";
                margin= mkLiteral "8px 0px 0px 8px";
                border= mkLiteral "0px 0px 8px 0px";
                border-color = mkLiteral "@button-underline";
            };

            "textbox-prompt-colon" = lib.mkForce {
                expand = false;
                str = "=";
            };

            "entry" = lib.mkForce {
                padding = mkLiteral "12px 13px -4px 11px";
                margin = mkLiteral "8px 8px 0px 8px";
                text-color = mkLiteral "@fg-col";
                background-color = mkLiteral "@blank";
                border-radius = mkLiteral "5px";
                border = mkLiteral "0px 0px 8px 0px";
                border-color = mkLiteral "@blank-underline";
            };

            "listview" = lib.mkForce {
                border = mkLiteral "0px 0px 0px";
                margin = mkLiteral "27px 5px -13px 5px";
                background-color = mkLiteral "#00000000";
                columns = 1;
            };

            "element" = lib.mkForce {
                padding = mkLiteral "12px 12px 12px 12px";
                background-color = mkLiteral "@blank";
                text-color = mkLiteral "@fg-col";
                margin = mkLiteral "0px 0px 8px 0px";
                border-radius = mkLiteral "5px";
                border = mkLiteral "0px 0px 8px 0px";
                border-color = mkLiteral "@blank-underline";
            };

            "element-icon" = lib.mkForce {
                size = mkLiteral "25px";
                background-color = mkLiteral "#00000000";
            };

            "element selected" = lib.mkForce {
                background-color = mkLiteral "@button";
                text-color = mkLiteral "@fg-col2";
                border-radius = mkLiteral "5px";
                border = mkLiteral "0px 0px 8px 0px";
                border-color = mkLiteral "@button-underline";
            };

            "button" = lib.mkForce {
                padding = mkLiteral "12px";
                margin = mkLiteral "10px 5px 10px 5px";
                background-color = mkLiteral "@blank";
                text-color = mkLiteral "@tab";
                vertical-align = mkLiteral "0.5"; 
                horizontal-align = mkLiteral "0.5";
                border-radius = mkLiteral "5px";
                border = mkLiteral "0px 0px 8px 0px";
                border-color = mkLiteral "@blank-underline";
            };

            "button selected" = lib.mkForce {
                background-color = mkLiteral "@bg-col-light";
                text-color = mkLiteral "@tab-selected";
                border-radius = mkLiteral "5px";
                border = mkLiteral "0px 0px 8px 0px";
                border-color = mkLiteral "@button-underline";
            };

          };
        };
      };
      # home.file.".config/rofi/config-long.rasi".text = ''
      #   @import "~/.config/rofi/config.rasi"
      #   window {
      #     width= 40%;
      #   }
      #   entry {
      #     placeholder= "🔎 Search       ";
      #   }
      #   listview {
      #     columns= 1;
      #     lines= 8;
      #     scrollbar= true;
      #   }
      # '';
    };
  };
}
