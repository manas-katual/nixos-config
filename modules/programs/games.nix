{ pkgs, userSettings, ... }:

{

  programs = {
    steam = {
      enable = true;
      gamescopeSession = {
        enable = true;
      };
    };
    gamemode = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    mangohud
		goverlay
    #lutris
    heroic
    protonup
  ];

  home-manager.users.${userSettings.username} = {
    home.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "\\\${HOME}/.steam/root/compatibilitytools.d";
    };

		# after this run "protonup" command in terminal
    
  };

}
