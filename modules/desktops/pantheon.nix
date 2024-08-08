{ config, lib, options, ... }:
{
  config = lib.mkIf (config.my.desktop.option == "pantheon") {

  services.xserver.desktopManager.pantheon.enable = true;
  services.pantheon.apps.enable = false;

};
}
