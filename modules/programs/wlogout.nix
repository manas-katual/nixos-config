{
  config,
  lib,
  userSettings,
  ...
}: {
  config = lib.mkIf (config.wlwm.enable && !config.sway.enable && (userSettings.style == "waybar-cool" || userSettings.style == "waybar-ddubs" || userSettings.style == "waybar-dwm" || userSettings.style == "waybar-jerry" || userSettings.style == "waybar-macos" || userSettings.style == "waybar-nekodyke" || userSettings.style == "waybar-simple")) {
    home-manager.users.${userSettings.username} = {
      home.file.".config/wlogout/icons" = {
        source = ./icons;
        recursive = true;
      };

      programs.wlogout = {
        enable = true;
        layout = [
          {
            label = "lock";
            action =
              if (config.programs.hyprland.enable == true)
              then "sleep 1; hyprlock"
              else "sleep 1; swaylock";
            text = "Lock";
            keybind = "l";
          }
          {
            label = "logout";
            action =
              if (config.programs.hyprland.enable == true)
              then "sleep 1; hyprctl dispatch exit"
              else "sleep 1; loginctl terminate-user $USER";
            text = "Logout";
            keybind = "e";
          }
          {
            label = "shutdown";
            action = "sleep 1; systemctl poweroff";
            text = "Shutdown";
            keybind = "s";
          }
          {
            label = "reboot";
            action = "sleep 1; systemctl reboot";
            text = "Reboot";
            keybind = "r";
          }
        ];

        style = ''
          * {
              font-family: "JetBrainsMono NF", FontAwesome, sans-serif;
              background-image: none;
              font-size: 24px;
          }

          window {
              background-color: transparent;
          }

          button {
              color: #${config.lib.stylix.colors.base0D};
              background-color: #${config.lib.stylix.colors.base00};
              outline-style: none;
              border: none;
              border-width: 0px;
              background-repeat: no-repeat;
              background-position: center;
              background-size: 10%;
              border-radius: 20px;
              box-shadow: none;
              text-shadow: none;
              animation: gradient_f 20s ease-in infinite;
          }

          button:focus {
              background-color: #${config.lib.stylix.colors.base0D};
              background-size: 20%;
          }

          button:hover {
              background-color: #${config.lib.stylix.colors.base0D};
              background-size: 25%;
              border-radius: 35px;
              animation: gradient_f 20s ease-in infinite;
              transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
          }

          button:hover#lock {
              border-radius: 35px 35px 0px 35px;
              margin : 10px 0px 0px 10px;
          }

          button:hover#logout {
              border-radius: 35px 0px 35px 35px;
              margin : 0px 0px 10px 10px;
          }

          button:hover#shutdown {
              border-radius: 35px 35px 35px 0px;
              margin : 10px 10px 0px 0px;
          }

          button:hover#reboot {
              border-radius: 0px 35px 35px 35px;
              margin : 0px 10px 10px 0px;
          }

          #lock {
              background-image: image(url("icons/lock.png"));
              border-radius: 20px 0px 0px 0px;
              margin : 35px 0px 0px 35px;
          }

          #logout {
              background-image: image(url("icons/logout.png"));
              border-radius: 0px 0px 0px 20px;
              margin : 0px 0px 35px 35px;
          }

          #shutdown {
              background-image: image(url("icons/shutdown.png"));
              border-radius: 0px 20px 0px 0px;
              margin : 35px 35px 0px 0px;
          }

          #reboot {
              background-image: image(url("icons/reboot.png"));
              border-radius: 0px 0px 20px 0px;
              margin : 0px 35px 35px 0px;
          }
        '';
      };
    };
  };
}
