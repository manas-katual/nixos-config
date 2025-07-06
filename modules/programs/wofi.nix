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
          text =
            ''
              @define-color rosewater #''
            + config.lib.stylix.colors.base07
            + ''              ;
                          @define-color flamingo #''
            + config.lib.stylix.colors.base06
            + ''              ;
                          @define-color pink #''
            + config.lib.stylix.colors.base05
            + ''              ;
                          @define-color mauve #''
            + config.lib.stylix.colors.base04
            + ''              ;
                          @define-color red #''
            + config.lib.stylix.colors.base09
            + ''              ;
                          @define-color maroon #''
            + config.lib.stylix.colors.base08
            + ''              ;
                          @define-color peach #''
            + config.lib.stylix.colors.base0A
            + ''              ;
                          @define-color yellow #''
            + config.lib.stylix.colors.base0A
            + ''              ;
                          @define-color green #''
            + config.lib.stylix.colors.base0B
            + ''              ;
                          @define-color teal #''
            + config.lib.stylix.colors.base0C
            + ''              ;
                          @define-color sky #''
            + config.lib.stylix.colors.base0D
            + ''              ;
                          @define-color sapphire #''
            + config.lib.stylix.colors.base0D
            + ''              ;
                          @define-color blue #''
            + config.lib.stylix.colors.base0C
            + ''              ;
                          @define-color lavender #''
            + config.lib.stylix.colors.base0E
            + ''              ;
                          @define-color text #''
            + config.lib.stylix.colors.base05
            + ''              ;
                          @define-color subtext1 #''
            + config.lib.stylix.colors.base04
            + ''              ;
                          @define-color subtext0 #''
            + config.lib.stylix.colors.base03
            + ''              ;
                          @define-color overlay2 #''
            + config.lib.stylix.colors.base02
            + ''              ;
                          @define-color overlay1 #''
            + config.lib.stylix.colors.base02
            + ''              ;
                          @define-color overlay0 #''
            + config.lib.stylix.colors.base01
            + ''              ;
                          @define-color surface2 #''
            + config.lib.stylix.colors.base01
            + ''              ;
                          @define-color surface1 #''
            + config.lib.stylix.colors.base00
            + ''              ;
                          @define-color surface0 #''
            + config.lib.stylix.colors.base00
            + ''              ;
                          @define-color base #''
            + config.lib.stylix.colors.base00
            + ''              ;
                          @define-color mantle #''
            + config.lib.stylix.colors.base01
            + ''              ;
                          @define-color crust #''
            + config.lib.stylix.colors.base02
            + ''                ;

              * {
                font-family: 'CaskaydiaCove Nerd Font', monospace;
                font-size: 18px;
              }

              /* Window */
              window {
                margin: 0px;
                padding: 10px;
                border: 2px solid @lavender;
                /*border-radius: 8px;*/
                background-color: @base;
              }

              /* Inner Box */
              #inner-box {
                margin: 5px;
                padding: 10px;
                border: none;
                background-color: @base;
              }

              /* Outer Box */
              #outer-box {
                margin: 5px;
                padding: 10px;
                border: none;
                background-color: @base;
              }

              /* Scroll */
              #scroll {
                margin: 0px;
                padding: 10px;
                border: none;
                background-color: @base;
              }

              /* Input */
              #input {
                margin: 5px 20px;
                padding: 10px;
                border: none;
                border-radius: 0.1em;
                color: @text;
                background-color: @base;
              }

              #input image {
                  border: none;
                  color: @red;
              }

              #input * {
                outline: 4px solid @red!important;
              }

              /* Text */
              #text {
                margin: 5px;
                border: none;
                color: @text;
              }

              #entry {
                background-color: @base;
              }

              #entry arrow {
                border: none;
                color: @lavender;
              }

              /* Selected Entry */
              #entry:selected {
                border: 0.11em solid @lavender;
              }

              #entry:selected #text {
                color: @mauve;
              }

              #entry:drop(active) {
                background-color: @lavender!important;
              }
            '';
        };
      };
    };
  };
}
