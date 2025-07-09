{
  config,
  userSettings,
  lib,
  ...
}: {
  config = lib.mkIf (config.sway.enable && userSettings.style == "waybar-simple" || userSettings.style == "waybar-dwm") {
    home-manager.users.${userSettings.username} = {
      services.mako = {
        enable = true;
        # backgroundColor = "#${config.lib.stylix.colors.base01}";
        # borderColor = "#${config.lib.stylix.colors.base0E}";
        borderRadius = 5;
        borderSize = 2;
        # textColor = "#${config.lib.stylix.colors.base04}";
        layer = "overlay";
      };
    };
  };
}
