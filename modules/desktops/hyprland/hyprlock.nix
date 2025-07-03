{
  config,
  pkgs,
  lib,
  userSettings,
  host,
  inputs,
  ...
}:
with lib;
with host; {
  config = mkIf (config.hyprland.enable) {
    security.pam.services.hyprlock = {
      # text = "auth include system-auth";
      text = "auth include login";
      enableGnomeKeyring = true;
    };
    home-manager.users.${userSettings.username} = {
      programs.hyprlock = {
        enable = true;

        package = pkgs.hyprlock;

        settings = {
          general = {
            hide_cursor = true;
            no_fade_in = false;
            disable_loading_bar = true;
            ignore_empty_input = true;
            fractional_scaling = 0;
          };

          background = lib.mkForce [
            {
              monitor = "";
              path = "${inputs.walls}/forest_fog_deer.png";
              blur_passes = 2;
              contrast = 0.8916;
              brightness = 0.8172;
              vibrancy = 0.1696;
              vibrancy_darkness = 0.0;
            }
          ];

          shape = [
            # User box
            {
              monitor = "";
              size = "300, 50";
              color = "rgba(102, 92, 84, 0.33)";
              rounding = 10;
              border_color = "rgba(255, 255, 255, 0)";
              position = "0, ${
                if hostName == "nokia"
                then "270"
                else "120"
              }";
              halign = "center";
              valign = "bottom";
            }
          ];

          label = [
            # Time
            {
              monitor = "";
              text = ''cmd[update:1000] echo "$(date +'%k:%M')"'';
              color = "rgba(235, 219, 178, 0.9)";
              font_size = 115;
              font_family = "Maple Mono Bold";
              shadow_passes = 3;
              position = "0, ${
                if hostName == "nokia"
                then "-150"
                else "-25"
              }";
              halign = "center";
              valign = "top";
            }
            # Date
            {
              monitor = "";
              text = ''cmd[update:1000] echo "- $(date +'%A, %B %d') -" '';
              color = "rgba(235, 219, 178, 0.9)";
              font_size = 18;
              font_family = "Maple Mono";
              shadow_passes = 3;
              position = "0, ${
                if hostName == "nokia"
                then "-350"
                else "-225"
              }";
              halign = "center";
              valign = "top";
            }
            # Username
            {
              monitor = "";
              text = "  $USER";
              color = "rgba(235, 219, 178, 1)";
              font_size = 15;
              font_family = "Maple Mono Bold";
              position = "0, ${
                if hostName == "nokia"
                then "281"
                else "131"
              }";
              halign = "center";
              valign = "bottom";
            }
          ];

          input-field = lib.mkForce [
            {
              monitor = "";
              size = "300, 50";
              outline_thickness = 1;
              rounding = 10;
              dots_size = 0.25;
              dots_spacing = 0.4;
              dots_center = true;
              outer_color = "rgba(102, 92, 84, 0.33)";
              inner_color = "rgba(102, 92, 84, 0.33)";
              color = "rgba(235, 219, 178, 0.9)";
              font_color = "rgba(235, 219, 178, 0.9)";
              font_size = 14;
              font_family = "Maple Mono Bold";
              fade_on_empty = false;
              placeholder_text = ''<i><span foreground="##fbf1c7">Enter Password</span></i>'';
              hide_input = false;
              position = "0, ${
                if hostName == "nokia"
                then "200"
                else "50"
              }";
              halign = "center";
              valign = "bottom";
            }
          ];
        };
      };
    };
  };
}
