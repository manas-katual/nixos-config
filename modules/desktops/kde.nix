{ config, pkgs, lib, options, ... }:
{
  
  config = lib.mkIf (config.my.desktop.option == "kde") {
   
   services.desktopManager.plasma6.enable = true;
   environment.plasma6.excludePackages = with pkgs.kdePackages; [
     plasma-browser-integration
     konsole
     elisa
     gwenview
     okular
     kate
     khelpcenter
     xterm
     kwrite
   ];
 
 };
}
