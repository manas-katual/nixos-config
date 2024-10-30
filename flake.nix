{
  description = "My system configuration";

  inputs = {

    # nix packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # stylix
    stylix.url = "github:danth/stylix";

  };

  outputs = inputs@ { self, nixpkgs, home-manager, stylix, ... }:

    let
      userSettings = {
	username = "manas";
	#host = "dell";
	terminal = "kitty";
	theme = "everforest";
      };

    in {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
	inherit inputs nixpkgs home-manager userSettings stylix;
      }
    );
  };
}
