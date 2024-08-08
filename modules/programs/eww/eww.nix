{ userSettings, ... }:

{
	home-manager.users.${userSettings} = {
		programs.eww.enable = false;
		#programs.eww.configDir = ./eww;
	};
}
