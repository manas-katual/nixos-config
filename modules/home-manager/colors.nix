{ inputs, userSettings, ... }:

{
		imports = [ 
			inputs.nix-colors.homeManagerModules.default
			#../mako/mako.nix
		];

		colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
}
