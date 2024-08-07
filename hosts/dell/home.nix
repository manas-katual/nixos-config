{ inputs, pkgs, config, options, lib, userSettings, ... }:

{

  imports = [
    #inputs.stylix.homeManagerModules.stylix
    ../../modules/home-manager/center.nix
  ];

  home = {
    username = "${userSettings.username}";
    homeDirectory = "/home/${userSettings.username}";
    stateVersion = "23.11";
  };
 

}
