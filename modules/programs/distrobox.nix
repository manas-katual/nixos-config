{ config, lib, pkgs, userSettings, ... }:

{

virtualisation.podman = {
  enable = true;
  dockerCompat = true;
};

environment.systemPackages = [ pkgs.distrobox ];
}
