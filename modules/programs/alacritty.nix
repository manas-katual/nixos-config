{
  userSettings,
  lib,
  ...
}: {
  home-manager.users.${userSettings.username} = {
    programs.alacritty = lib.mkIf (userSettings.terminal == "alacritty") {
      enable = true;
      settings = {
        window = {
          # opacity = 0.95;
          padding.x = 10;
          padding.y = 10;
        };
        # font = {
        #   size = 13.0;
        #   draw_bold_text_with_bright_colors = true;
        #   normal = {
        #     family = "Intel One Mono";
        #     style = "Normal";
        #   };
        # };
        cursor = {
          style = {
            shape = "Beam";
            blinking = "Always";
          };
        };

        # Colors (Gruvbox Material Medium Dark)
        # colors = lib.mkForce {
        #   primary = {
        #     background = "#282828";
        #     foreground = "#d4be98";
        #   };
        #   normal = {
        #     black = "#3c3836";
        #     red = "#ea6962";
        #     green = "#a9b665";
        #     yellow = "#d8a657";
        #     blue = "#7daea3";
        #     magenta = "#d3869b";
        #     cyan = "#89b482";
        #     white = "#d4be98";
        #   };
        #   bright = {
        #     black = "#3c3836";
        #     red = "#ea6962";
        #     green = "#a9b665";
        #     yellow = "#d8a657";
        #     blue = "#7daea3";
        #     magenta = "#d3869b";
        #     cyan = "#89b482";
        #     white = "#d4be98";
        #   };
        # };
      };
    };
  };
}
