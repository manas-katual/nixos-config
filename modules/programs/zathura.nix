{config, userSettings, ...}: 

{
	home-manager.users.${userSettings.username} = {
		programs.zathura = {
			enable = true;
		};
	};
}
