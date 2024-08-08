{ userSettings, ... }:

{
  
	home-manager.users.${userSettings.username} = {
		programs.htop = {
			enable = true;
			settings = {
				tree_view = 1;
			};
		};
	};

}
