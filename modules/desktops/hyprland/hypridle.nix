{
  userSettings,
  config,
  pkgs,
  host,
  lib,
  ...
}:
with host;
with lib; {
  config = mkIf (config.hyprland.enable) {
    wlwm.enable = true;
    home-manager.users.${userSettings.username} = {
      services.hypridle = {
        enable = true;
        package = pkgs.hypridle;
        settings = {
          general = {
            before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
            after_sleep_cmd = "${config.programs.hyprland.package}/bin/hyprctl dispatch dpms on";
            ignore_dbus_inhibit = true;
            lock_cmd = "pidof ${pkgs.hyprlock}/bin/hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
          };
          listener = [
            {
              timeout = 300;
              on-timeout = "${pkgs.hyprlock}/bin/hyprlock";
            }
            {
              timeout = 1800;
              on-timeout = "${config.programs.hyprland.package}/bin/hyprctl dispatch dpms off";
              on-resume = "${config.programs.hyprland.package}/bin/hyprctl dispatch dpms on";
            }
          ];
        };
      };
    };
  };
}
