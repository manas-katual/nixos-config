#
#  System Menu
#
{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}: {
  config = lib.mkIf (config.wlwm.enable && config.sway.enable || userSettings.style == "hyprpanel" || userSettings.style == "mithril") {
    home-manager.users.${userSettings.username} = {
      home = {
        packages = with pkgs; [
          wofi
        ];
      };

      home.file = {
        ".config/wofi/config" = {
          text = ''
            prompt=Search...
            filter_rate=100
            allow_markup=false
            no_actions=true
            allow_images=true
            image_size=30
            hide_scroll=true
          '';
        };
        ".config/wofi/style.css" = {
          text = ''

            * {
              font-family: "JetBrainsMono Nerd Font";
              border-radius: 3px;
              border: none;
            }

            window {
              font-size: 32px;
              background-color: rgba(50, 50, 0.9);
              color: white;
              border-bottom: 3px solid #${config.lib.stylix.colors.base05};
            }

            #entry {
              padding: 0.25em;
            }

            #entry:selected {
              background: linear-gradient(90deg, #bbccdd, #cca5dd);
              background-color: #${config.lib.stylix.colors.base0D};
              color: #${config.lib.stylix.colors.base01};
            }

            #text:selected {
              color: #${config.lib.stylix.colors.base01};
            }

            #input {
              background-color: rgba(50, 50, 50, 0.5);
              color: #${config.lib.stylix.colors.base05};
              padding: 0.25em;
            }
          '';
        };
      };
    };
  };
}
