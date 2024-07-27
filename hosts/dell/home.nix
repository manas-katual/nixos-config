{ inputs, pkgs, config, options, lib, userSettings, ... }:

{

  imports = [
    #inputs.stylix.homeManagerModules.stylix
    #./zsh.nix
    ../../modules/home-manager/center.nix
    ../../modules/home-manager/custom-options/home-options.nix
  ];

  home = {
    username = "${userSettings.username}";
    homeDirectory = "/home/${userSettings.username}";
    stateVersion = "23.11";
  };
 
  home.packages = with pkgs; [
    nwg-dock-hyprland
    nwg-drawer
  ]; 
 # ++ (if (config.wayland.windowManager.hyprland.enable == true) 
  #        then [pkgs.rofi-wayland]
   #     else 
    #      (if (config.wayland.windowManager.sway.enable == true)
     #       then [pkgs.rofi-wayland]
      #  else []));

 # xdg.configFile = {
 #   # you don't have to rebuild..., but have to give full path..
 #   "sway/config".source = config.lib.file.mkOutOfStoreSymlink
 #     "/home/smaalks/setup/modules/desktops/sway/config";
 # };

}
