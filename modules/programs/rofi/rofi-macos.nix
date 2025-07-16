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
  config = lib.mkIf (config.wlwm.enable && !config.sway.enable && (userSettings.style == "waybar-macos" || userSettings.style == "waybar-dwm")) {
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

      home.file.".config/rofi/rofi-power-menu.rasi".text = ''
        /**
         *
         * Author : Aditya Shakya (adi1090x)
         * Github : @adi1090x
         *
         * Rofi Theme File
         * Rofi Version: 1.7.3
         **/

        /*****----- Configuration -----*****/
        configuration {
            show-icons:                 true;
        }

        /*****----- Global Properties -----*****/
        * {
            /* Resolution : 1920x1080 */
            mainbox-spacing:             100px;
            mainbox-margin:              100px 300px;
            message-margin:              0px 400px;
            message-padding:             15px;
            message-border-radius:       100%;
            listview-spacing:            50px;
            element-padding:             55px 60px;
            element-border-radius:       100%;

            prompt-font:                 "JetBrains Mono Nerd Font Bold Italic 64";
            textbox-font:                "JetBrains Mono Nerd Font 16";
            element-text-font:           "feather 64";

            background-window:           black/5%;
            background-normal:           white/5%;
            background-selected:         white/15%;
            foreground-normal:           white;
            foreground-selected:         white;
        }

        /*****----- Main Window -----*****/
        window {
            transparency:                "real";
            location:                    center;
            anchor:                      center;
            fullscreen:                  true;
            cursor:                      "default";
            background-color:            var(background-window);
        }

        /*****----- Main Box -----*****/
        mainbox {
            enabled:                     true;
            spacing:                     var(mainbox-spacing);
            margin:                      var(mainbox-margin);
            background-color:            transparent;
            children:                    [ "dummy", "inputbar", "listview", "message", "dummy" ];
        }

        /*****----- Inputbar -----*****/
        inputbar {
            enabled:                     true;
            background-color:            transparent;
            children:                    [ "dummy", "prompt", "dummy"];
        }

        dummy {
            background-color:            transparent;
        }

        prompt {
            enabled:                     true;
            font:                        var(prompt-font);
            background-color:            transparent;
            text-color:                  var(foreground-normal);
        }

        /*****----- Message -----*****/
        message {
            enabled:                     true;
            margin:                      var(message-margin);
            padding:                     var(message-padding);
            border-radius:               var(message-border-radius);
            background-color:            var(background-normal);
            text-color:                  var(foreground-normal);
        }
        textbox {
            font:                        var(textbox-font);
            background-color:            transparent;
            text-color:                  inherit;
            vertical-align:              0.5;
            horizontal-align:            0.5;
        }

        /*****----- Listview -----*****/
        listview {
            enabled:                     true;
            expand:                      false;
            columns:                     5;
            lines:                       1;
            cycle:                       true;
            dynamic:                     true;
            scrollbar:                   false;
            layout:                      vertical;
            reverse:                     false;
            fixed-height:                true;
            fixed-columns:               true;

            spacing:                     var(listview-spacing);
            background-color:            transparent;
            cursor:                      "default";
        }

        /*****----- Elements -----*****/
        element {
            enabled:                     true;
            padding:                     var(element-padding);
            border-radius:               var(element-border-radius);
            background-color:            var(background-normal);
            text-color:                  var(foreground-normal);
            cursor:                      pointer;
        }
        element-text {
            font:                        var(element-text-font);
            background-color:            transparent;
            text-color:                  inherit;
            cursor:                      inherit;
            vertical-align:              0.5;
            horizontal-align:            0.5;
        }
        element selected.normal {
            background-color:            var(background-selected);
            text-color:                  var(foreground-selected);
        }
      '';
    };
  };
}
