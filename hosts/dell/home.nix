{ inputs, pkgs, config, lib, userSettings, ... }:

{

  imports = [
    #inputs.stylix.homeManagerModules.stylix
  ];

  home = {
    username = "${userSettings.username}";
    homeDirectory = "/home/${userSettings.username}";
    stateVersion = "23.11";
  };
 

}
