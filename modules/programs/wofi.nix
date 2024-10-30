
#
#  System Menu
#

{ config, lib, pkgs, userSettings, ... }:

{
  config = lib.mkIf (config.wlwm.enable) {
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
            window {
	      font-size: 32px;
              background-color: #${config.lib.stylix.colors.base00};
              /*background-color: rgba(0, 0, 0, 0.8);*/
            }

            #input {
              all: unset;
              border: none;
              color: #${config.lib.stylix.colors.base05}
              background-color: #${config.lib.stylix.colors.base00};
              padding-left: 5px;
            }

            #outer-box {
              border: none;
              border-bottom: 1px solid #${config.lib.stylix.colors.base09};
            }

            #text:selected {
              /*color: rgba(255, 255, 255, 0.8);*/
              color: rgba(0, 0, 0, 0.8);
            }

            #entry {
              color: #${config.lib.stylix.colors.base05};
              padding-right: 10px;
            }

            #entry:selected {
              all: unset;
              border-radius: 0px;
              background-color: #${config.lib.stylix.colors.base09};
              padding-right: 10px;
            }

            #img {
              padding-right: 5px;
              padding-left: 10px;
            }
          '';
        };
      };
    };
  };
}

