{ config, lib, pkgs, callPackage, ... }:

{

  services.emacs.enable = true;

	  nixpkgs.overlays = [
			(import (builtins.fetchTarball {
				url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
			}))
  	];

  environment.systemPackages = [
    pkgs.emacs
    pkgs.cmake
  ];
}
