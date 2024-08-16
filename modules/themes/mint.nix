{ config, pkgs, lib, userSettings, ... }:

{
  
	home-manager.users.${userSettings.username} = {
		# qt theme
		qt = {
			enable = true;
			platformTheme.name = "adwaita";
			style = {
				name = "adwaita-dark";
				package = pkgs.adwaita-qt;
			};
		};

		# gtk theme
		gtk = {    
			enable = true;
			#font = {
			#	name = "Intel One Mono";
			#	size = 14;
			#	package = pkgs.intel-one-mono;
			#};
			#theme = {
			#	package = pkgs.mint-themes;
			#	name = "Mint-Y-Dark-Teal";
			#};
			iconTheme = {
				package = pkgs.papirus-icon-theme;
				name = "Papirus-Dark";
			};
			gtk3 = {
				extraConfig = {
					gtk-application-prefer-dark-theme = 1;
				};
			};
			gtk4 = {
				extraConfig = {
					gtk-application-prefer-dark-theme = 1;
				};
			};
		}; 
	};

}

