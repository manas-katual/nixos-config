{
  config,
  pkgs,
  userSettings,
  lib,
  ...
}:
with lib; {
  config = mkIf (config.wlwm.enable) {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
          command =
            if (config.hyprland.enable)
            then "${config.programs.hyprland.package}/bin/Hyprland"
            else if (config.sway.enable)
            then "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway"
            else "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri"; # tuigreet not needed with exec-once hyprlock
          user = userSettings.username;
        };
      };
      vt = 7;
    };
  };
}
