#
#  File Browser
#

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pcmanfm
    shared-mime-info
    lxde.lxmenu-data
  ];
}
