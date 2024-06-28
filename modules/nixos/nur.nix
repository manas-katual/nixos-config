{ inputs, config, pkgs, nur, ... }:

{
  modules = [
		nur.nixosModules.nur
	];				
}
