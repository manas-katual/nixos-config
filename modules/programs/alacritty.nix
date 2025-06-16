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
          padding.x = 10;
          padding.y = 10;
        };
        cursor = {
          style = {
            shape = "Beam";
            blinking = "Always";
          };
        };
      };
    };
  };
}
