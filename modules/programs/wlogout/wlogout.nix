{ config, lib, userSettings, ... }:

{
	config = lib.mkIf (config.programs.hyprland.enable == true || config.programs.sway.enable == true || config.programs.wayfire.enable == true) {

		home-manager.users.${userSettings.username} = {
  		programs.wlogout = {
				enable = true;
				layout = [
					{
    				label = "lock";
						action = if (config.programs.hyprland.enable == true) then "hyprlock" else "swaylock";
    				text = "Lock";
    				keybind = "l";
					}
					{
    				label = "logout";
						action = if (config.programs.hyprland.enable == true) then "hyprctl dispatch exit" else "wayland-logout"; 
    				text = "Logout";
    				keybind = "e";
					}
					{
    				label = "shutdown";
    				action = "systemctl poweroff";
    				text = "Shutdown";
    				keybind = "s";
					}
					{
    				label = "reboot";
    				action = "systemctl reboot";
						text = "Reboot";
    				keybind = "r";
					}
				];

				style = ''
					/** ********** Fonts ********** **/
					* {
  					font-family: "JetBrains Mono", "Iosevka Nerd Font", sans-serif;
  					font-size: 14px;
  					font-weight: bold;
					}

					/** ********** Main Window ********** **/
					window {
   					background-color: #1e1e2e;
					}

					/** ********** Buttons ********** **/
					button {
   					color: #ffffff;
   					background-color: #11111b;
   					outline-style: none;
   					border: none;
   					border-width: 0px;
   					background-repeat: no-repeat;
   					background-position: center;
   					background-size: 10%;
   					border-radius: 0px;
   					box-shadow: none;
   					text-shadow: none;
   					animation: gradient_f 20s ease-in infinite;
					}

					button:focus {
  					background-color: #a6adc8;
  					background-size: 20%;
					}

					button:hover {
						background-color: #89b4fa;
						background-size: 25%;
						border-radius: 20px;
						animation: gradient_f 20s ease-in infinite;
						transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
						outline-style: none;
					}

					button:hover#lock {
							border-radius: 20px 20px 0px 20px;
							margin : 30px 0px 0px 60px;
					}

					button:hover#logout {
							border-radius: 20px 0px 20px 20px;
							margin : 0px 0px 30px 60px;
					}

					button:hover#shutdown {
							border-radius: 20px 20px 20px 0px;
							margin : 30px 60px 0px 0px;
					}

					button:hover#reboot {
							border-radius: 0px 20px 20px 20px;
							margin : 0px 60px 30px 0px;
					}
					/** ********** Icons ********** **/
					#lock {
						background-image: url("/home/smaalks/setup/modules/programs/wlogout/icons/lock.png");
						border-radius: 25px 0px 0px 0px;
						margin : 35px 0px 0px 10px;
					}

					#logout {
						background-image: url("/home/smaalks/setup/modules/programs/wlogout/icons/shutdown.png");
						border-radius: 0px 0px 0px 25px;
						margin : 0px 0px 35px 10px;
					}

					#shutdown {
						background-image: url("/home/smaalks/setup/modules/programs/wlogout/icons/reboot.png");
						border-radius: 0px 25px 0px 0px;
						margin : 35px 10px 0px 0px;
					}

					#reboot {
						background-image: url("/home/smaalks/setup/modules/programs/wlogout/icons/logout.png");
						border-radius: 0px 0px 25px 0px;
						margin : 0px 10px 35px 0px;
					}

				'';
			};
		};
	};
}
