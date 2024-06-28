{ config, pkgs, inputs, ... }:
{
  imports = [
	  inputs.nur.hmModules.nur
	];

  home.packages = with pkgs; [
	  config.nur.repos.ataraxiasjel.waydroid-script
  ];
}
