#
#  Bar
#

{ config, lib, pkgs, userSettings, ... }:

{
    environment.systemPackages = with pkgs; [
      eww # Widgets
      jq # JSON Processor
      socat # Data Transfer
    ];

    home-manager.users.${userSettings.username} = {
      home.file.".config/eww" = {
        source = ./eww;
        recursive = true;
      };
    };
}
