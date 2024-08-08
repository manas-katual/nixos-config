{ inputs, config, pkgs, ... }:

{
  imports = [
		inputs.nur.nixosModules.nur
	];				

  environment.systemPackages = with pkgs; [
    config.nur.repos.ataraxiasjel.waydroid-script
  ];

}
