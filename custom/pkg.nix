{ config, pkgs, ... }:

let
  # apps from github
  wayvibes = pkgs.callPackage ./apps/wayvibes.nix {};
  
  # appimages
  Mechvibes = import ./appimages/mechvibes.nix { inherit pkgs; };
  webos-dev-manager = import ./appimages/webos-dev-manager.nix { inherit pkgs; };
in
  {
  environment.systemPackages = with pkgs; [
    wayvibes
    Mechvibes
    webos-dev-manager
  ];
}


