{ pkgs, config, userSettings, ... }:

{
 	home-manager.users.${userSettings.username} = {
		gtk = {
			iconTheme = {
				name = "Papirus-Dark";
				package = pkgs.papirus-icon-theme;
			};
			gtk3.extraConfig = {
				gtk-application-prefer-dark-theme = 1;
			};
			gtk4.extraConfig = {
				gtk-application-prefer-dark-theme = 1;
			};
		};
		qt = {
			enable = true;
			style.name = "adwaita-dark";
			platformTheme.name = "gtk3";
		};
 };
 
}
