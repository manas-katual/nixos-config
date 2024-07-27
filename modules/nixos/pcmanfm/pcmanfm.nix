{ pkgs, config, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    pcmanfm
    lxmenu-data
    shared-mime-info
  ];
}
