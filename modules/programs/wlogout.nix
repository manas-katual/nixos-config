{
  config,
  lib,
  userSettings,
  ...
}: {
  config = lib.mkIf (config.sway.enable) {
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
            text = "sleep 1; Shutdown";
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
          	transition: 20ms;
          }
          window {
          	background-color: rgba(12, 12, 12, 0.1);
          }
          button {
          	color: #${config.lib.stylix.colors.base05};
            font-size:20px;
            background-repeat: no-repeat;
          	background-position: center;
          	background-size: 25%;
          	border-style: solid;
          	background-color: rgba(12, 12, 12, 0.3);
          	border: 3px solid #${config.lib.stylix.colors.base05};
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
          }
          button:focus,
          button:active,
          button:hover {
            color: #${config.lib.stylix.colors.base0B};
            background-color: rgba(12, 12, 12, 0.5);
            border: 3px solid #${config.lib.stylix.colors.base0B};
          }
          #logout {
          	margin: 10px;
          	border-radius: 20px;
          	background-image: image(url("icons/logout.png"));
          }
          #suspend {
          	margin: 10px;
          	border-radius: 20px;
          	background-image: image(url("icons/suspend.png"));
          }
          #shutdown {
          	margin: 10px;
          	border-radius: 20px;
          	background-image: image(url("icons/shutdown.png"));
          }
          #reboot {
          	margin: 10px;
          	border-radius: 20px;
          	background-image: image(url("icons/reboot.png"));
          }
          #lock {
          	margin: 10px;
          	border-radius: 20px;
          	background-image: image(url("icons/lock.png"));
          }
          #hibernate {
          	margin: 10px;
          	border-radius: 20px;
          	background-image: image(url("icons/hibernate.png"));
          }
        '';
      };
    };
  };
}
