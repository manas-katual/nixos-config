{
  config,
  pkgs,
  userSettings,
  lib,
  ...
}:
with lib; {
  config = mkIf (config.wlwm.enable && config.gnome.enable == false && config.cosmic.enable == false) {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
          command =
            if (config.hyprland.enable)
            then "${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop"
            else if (config.sway.enable)
            then "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway"
            else if (config.niri.enable)
            then "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri"
            else "";
          user = "${userSettings.username}";
        };
      };
      vt = 7;
    };
  };
}
