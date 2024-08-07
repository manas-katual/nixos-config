{ pkgs, userSettings, ... }:

{

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
		goverlay
    #lutris
    heroic
    bottles
    protonup
  ];

  programs.gamemode.enable = true;

  home-manager.users.${userSettings.username} = {
    home.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "\\\${HOME}/.steam/root/compatibilitytools.d";
    };
    
  };

}
