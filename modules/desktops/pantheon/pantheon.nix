{ config, lib, options, ... }:
{
  options = lib.mkIf (config.my.desktop.option == "pantheon") {

  services.xserver.desktopManager.pantheon.enable = true;
  services.pantheon.apps.enable = false;

};
}
