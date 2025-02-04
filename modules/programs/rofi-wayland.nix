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
            modi = "drun,filebrowser,run";
            show-icons = true;
            icon-theme = "Papirus";
            location = 0;
            font = "JetBrainsMono Nerd Font Mono 10";
            drun-display-format = "{icon} {name}";
            display-drun = " Apps";
            display-run = " Run";
            display-filebrowser = " File";
          };
          terminal = "${pkgs.${userSettings.terminal}}/bin/${userSettings.terminal}";
          # location = "center";
          # font = lib.mkForce "FiraCode Nerd Font Mono 11";
          theme = {
            "*" = lib.mkForce {
              normal-text = "#ffffff";
              separatorcolor = "#ffffff";
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
            "window" = lib.mkForce {
              transparency = "real";
              orientation = mkLiteral "vertical";
              cursor = mkLiteral "default";
              spacing = mkLiteral "0px";
              border = mkLiteral "2px";
              border-color = "@border-color";
              border-radius = mkLiteral "20px";
              background-color = mkLiteral "@bg";
            };
            "mainbox" = lib.mkForce {
              padding = mkLiteral "15px";
              enabled = true;
              orientation = mkLiteral "vertical";
              children = map mkLiteral [
                "inputbar"
                "listbox"
              ];
              background-color = mkLiteral "transparent";
            };
            "inputbar" = lib.mkForce {
              enabled = true;
              padding = mkLiteral "5px 5px 100px 5px";
              margin = mkLiteral "10px";
              background-color = mkLiteral "transparent";
              border-radius = "25px";
              orientation = mkLiteral "horizontal";
              children = map mkLiteral [
                "entry"
                "dummy"
                "mode-switcher"
              ];
              background-image = mkLiteral ''url("~/setup/modules/wallpapers/od_neon_warm.png", width)'';
            };
            "entry" = lib.mkForce {
              enabled = true;
              expand = false;
              width = mkLiteral "20%";
              padding = mkLiteral "10px";
              border-radius = mkLiteral "12px";
              background-color = mkLiteral "@selected";
              text-color = mkLiteral "@text-selected";
              cursor = mkLiteral "text";
              placeholder = "🖥️ Search ";
              placeholder-color = mkLiteral "inherit";
            };
            "listbox" = lib.mkForce {
              spacing = mkLiteral "10px";
              padding = mkLiteral "10px";
              background-color = mkLiteral "transparent";
              orientation = mkLiteral "vertical";
              children = map mkLiteral [
                "message"
                "listview"
              ];
            };
            "listview" = lib.mkForce {
              enabled = true;
              columns = 2;
              lines = 5;
              cycle = true;
              dynamic = true;
              scrollbar = false;
              layout = mkLiteral "vertical";
              reverse = false;
              fixed-height = false;
              fixed-columns = true;
              spacing = mkLiteral "10px";
              background-color = mkLiteral "transparent";
              border = mkLiteral "0px";
            };
            "dummy" = lib.mkForce {
              expand = true;
              background-color = mkLiteral "transparent";
            };
            "mode-switcher" = lib.mkForce {
              enabled = true;
              spacing = mkLiteral "10px";
              background-color = mkLiteral "transparent";
            };
            "button" = lib.mkForce {
              width = mkLiteral "5%";
              padding = mkLiteral "12px";
              border-radius = mkLiteral "12px";
              background-color = mkLiteral "@text-selected";
              text-color = mkLiteral "@text-color";
              cursor = mkLiteral "pointer";
            };
            "button selected" = lib.mkForce {
              background-color = mkLiteral "@selected";
              text-color = mkLiteral "@text-selected";
            };
            "scrollbar" = lib.mkForce {
              width = mkLiteral "4px";
              border = 0;
              handle-color = mkLiteral "@border-color";
              handle-width = mkLiteral "8px";
              padding = 0;
            };
            "element" = lib.mkForce {
              enabled = true;
              spacing = mkLiteral "10px";
              padding = mkLiteral "10px";
              border-radius = mkLiteral "12px";
              background-color = mkLiteral "transparent";
              cursor = mkLiteral "pointer";
            };
            "element normal.normal" = lib.mkForce {
              background-color = mkLiteral "inherit";
              text-color = mkLiteral "inherit";
            };
            "element normal.urgent" = lib.mkForce {
              background-color = mkLiteral "@urgent";
              text-color = mkLiteral "@foreground";
            };
            "element normal.active" = lib.mkForce {
              background-color = mkLiteral "@active";
              text-color = mkLiteral "@foreground";
            };
            "element selected.normal" = lib.mkForce {
              background-color = mkLiteral "@selected";
              text-color = mkLiteral "@text-selected";
            };
            "element selected.urgent" = lib.mkForce {
              background-color = mkLiteral "@urgent";
              text-color = mkLiteral "@text-selected";
            };
            "element selected.active" = lib.mkForce {
              background-color = mkLiteral "@urgent";
              text-color = mkLiteral "@text-selected";
            };
            "element alternate.normal" = lib.mkForce {
              background-color = mkLiteral "transparent";
              text-color = mkLiteral "inherit";
            };
            "element alternate.urgent" = lib.mkForce {
              background-color = mkLiteral "transparent";
              text-color = mkLiteral "inherit";
            };
            "element alternate.active" = lib.mkForce {
              background-color = mkLiteral "transparent";
              text-color = mkLiteral "inherit";
            };
            "element-icon" = lib.mkForce {
              background-color = mkLiteral "transparent";
              text-color = mkLiteral "inherit";
              size = mkLiteral "36px";
              cursor = mkLiteral "inherit";
            };
            "element-text" = lib.mkForce {
              background-color = mkLiteral "transparent";
              font = "JetBrainsMono Nerd Font Mono 12";
              text-color = mkLiteral "inherit";
              cursor = mkLiteral "inherit";
              vertical-align = mkLiteral "0.5";
              horizontal-align = mkLiteral "0.0";
            };
            "message" = lib.mkForce {
              background-color = mkLiteral "transparent";
              border = mkLiteral "0px";
            };
            "textbox" = lib.mkForce {
              padding = mkLiteral "12px";
              border-radius = mkLiteral "10px";
              background-color = mkLiteral "@bg-alt";
              text-color = mkLiteral "@bg";
              vertical-align = mkLiteral "0.5";
              horizontal-align = mkLiteral "0.0";
            };
            "error-message" = lib.mkForce {
              padding = mkLiteral "12px";
              border-radius = mkLiteral "20px";
              background-color = mkLiteral "@bg-alt";
              text-color = mkLiteral "@bg";
            };
          };
        };
      };
      home.file.".config/rofi/config-long.rasi".text = ''
        @import "~/.config/rofi/config.rasi"
        window {
          width: 40%;
        }
        entry {
          placeholder: "🔎 Search       ";
        }
        listview {
          columns: 1;
          lines: 8;
          scrollbar: true;
        }
      '';
    };
  };
}
