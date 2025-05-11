#
#  System Menu
#

{ config, lib, pkgs, userSettings, ... }:

let
  inherit (config.home-manager.users.${userSettings.username}.lib.formats.rasi) mkLiteral;
  colors = import ../theming/colors.nix;
in
{
  config = lib.mkIf (config.wlwm.enable) {
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
          theme = with colors.scheme.nord; {
            "*" = lib.mkForce { };
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
                border-color = mkLiteral "#${window-underline}";
                background-color = mkLiteral "#${window}";
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
                background-color = mkLiteral "#${button}";
                padding = mkLiteral "12px";
                text-color = mkLiteral "#${bg-col}";
                border-radius = mkLiteral "5px";
                margin= mkLiteral "8px 0px 0px 8px";
                border= mkLiteral "0px 0px 8px 0px";
                border-color = mkLiteral "#${button-underline}";
            };

            "textbox-prompt-colon" = lib.mkForce {
                expand = false;
                str = "=";
            };

            "entry" = lib.mkForce {
                padding = mkLiteral "12px 13px -4px 11px";
                margin = mkLiteral "8px 8px 0px 8px";
                text-color = mkLiteral "#${fg-col}";
                background-color = mkLiteral "#${blank}";
                border-radius = mkLiteral "5px";
                border = mkLiteral "0px 0px 8px 0px";
                border-color = mkLiteral "#${blank-underline}";
            };

            "listview" = lib.mkForce {
                border = mkLiteral "0px 0px 0px";
                margin = mkLiteral "27px 5px -13px 5px";
                background-color = mkLiteral "#00000000";
                columns = 1;
            };

            "element" = lib.mkForce {
                padding = mkLiteral "12px 12px 12px 12px";
                background-color = mkLiteral "#${blank}";
                text-color = mkLiteral "#${fg-col}";
                margin = mkLiteral "0px 0px 8px 0px";
                border-radius = mkLiteral "5px";
                border = mkLiteral "0px 0px 8px 0px";
                border-color = mkLiteral "#${blank-underline}";
            };

            "element-icon" = lib.mkForce {
                size = mkLiteral "25px";
                background-color = mkLiteral "#00000000";
            };

            "element selected" = lib.mkForce {
                background-color = mkLiteral "#${button}";
                text-color = mkLiteral "#${fg-col2}";
                border-radius = mkLiteral "5px";
                border = mkLiteral "0px 0px 8px 0px";
                border-color = mkLiteral "#${button-underline}";
            };

            "button" = lib.mkForce {
                padding = mkLiteral "12px";
                margin = mkLiteral "10px 5px 10px 5px";
                background-color = mkLiteral "#${blank}";
                text-color = mkLiteral "#${tab}";
                vertical-align = mkLiteral "0.5"; 
                horizontal-align = mkLiteral "0.5";
                border-radius = mkLiteral "5px";
                border = mkLiteral "0px 0px 8px 0px";
                border-color = mkLiteral "#${blank-underline}";
            };

            "button selected" = lib.mkForce {
                background-color = mkLiteral "#${bg-col-light}";
                text-color = mkLiteral "#${tab-selected}";
                border-radius = mkLiteral "5px";
                border = mkLiteral "0px 0px 8px 0px";
                border-color = mkLiteral "#${button-underline}";
            };

          };
        };
      };
    };
  };
}
