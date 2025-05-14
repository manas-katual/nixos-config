{
  config,
  userSettings,
  lib,
  ...
}:
with lib; {
  config = mkIf (config.hyprland.enable) {
    wlwm.enable = true;
    home-manager.users.${userSettings.username} = {
      # Game mode
      home.file = {
        ".config/hypr/gamemode.sh" = {
          text = ''
            #!/usr/bin/env sh

            HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
            if [ "$HYPRGAMEMODE" = 1 ] ; then
                hyprctl --batch "\
                    keyword animations:enabled 0;\
                    keyword decoration:shadow:enabled 0;\
                    keyword decoration:blur:enabled 0;\
                    keyword general:gaps_in 0;\
                    keyword general:gaps_out 0;\
                    keyword general:border_size 1;\
                    keyword decoration:rounding 0"
                exit
            fi
            hyprctl reload
          '';
          executable = true;
        };
      };

      # Place Files Inside Home Directory
      home.file = {
        "Pictures/Wallpapers" = {
          source = ../../wallpapers;
          recursive = true;
        };
      };
    };
  };
}
