{ inputs, ... }:

{

  imports = [
    #inputs.stylix.homeManagerModules.stylix
    #./zsh.nix
    ../../modules/home-manager/center.nix
  ];

  home = {
    username = "smaalks";
    homeDirectory = "/home/smaalks";
    stateVersion = "23.11";
  };
}
