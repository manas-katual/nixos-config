{ userSettings, ... }:

{
	home-manager.users.${userSettings.username} = {
		programs.git = {
			enable = true;
			userName = "manas-katual";
			userEmail = "manaskatual19@gmail.com";
			extraConfig = {
				init.defaultBranch = "main";
			};
		};
	};
}
