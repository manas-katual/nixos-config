{ pkgs, config, lib, options, ... }:

{
  options = lib.mkIf (config.my.desktop.option == "sway") {

  services.gnome.gnome-keyring.enable = true;

  programs.sway = {
  enable = true;
  package = pkgs.sway;
  wrapperFeatures.gtk = true;
  };


 };
}
