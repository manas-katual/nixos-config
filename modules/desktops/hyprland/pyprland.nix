# most of the times don't show on all workspaces lol
#
{
  config,
  pkgs,
  lib,
  userSettings,
  ...
}:
with lib; {
  config = mkIf (config.hyprland.enable) {
    wlwm.enable = true;
    home-manager.users.${userSettings.username} = {
      home.packages = with pkgs; [pyprland];

      home.file.".config/hypr/pyprland.toml".text = ''
        [pyprland]
        plugins = [
          "scratchpads",
        ]

        [scratchpads.term]
        animation = "fromTop"
        command = "kitty --class kitty-dropterm"
        class = "kitty-dropterm"
        size = "75% 60%"
        max_size = "1920px 100%"
        position = "150px 150px"
      '';
    };
  };
}
