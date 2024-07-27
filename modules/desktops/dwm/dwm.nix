{ config, pkgs, lib, options, ... }:
{

  options = lib.mkIf (config.my.desktop.option == "dwm") {
  
  services.xserver.windowManager.dwm.enable = true;

  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
    src = ./dwm;
  };

};
}
