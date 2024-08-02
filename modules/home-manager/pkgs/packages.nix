{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    #nwg-dock-hyprland
    #nwg-drawer
    pyprland
  ]; 

}
