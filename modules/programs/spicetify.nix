{ pkgs, inputs, userSettings, ... }:

#let
#  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
#in
{
  
	
	home-manager.users.${userSettings.username} = {

		imports = [
			inputs.spicetify-nix.homeManagerModules.default
		];

		programs.spicetify =
			{
			  enable = true;
			  enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
			 	 adblock
			 	 hidePodcasts
			 	 shuffle # shuffle+ (special characters are sanitized out of extension names)
			  ];
			  #theme = inputs.spicetify-nix.legacyPackages.${pkgs.system}.themes.onepunch;
			  #colorScheme = "comfy";
			};
	};
}
