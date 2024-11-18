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

    # running windows app
    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@ { self, nixpkgs, home-manager, stylix, winapps, ... }:

    let
      userSettings = {
	username = "manas";
	#host = "dell";
	terminal = "kitty";
	editor = "nvim";
	theme = "solarized-dark";
      };

    in {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
	inherit inputs nixpkgs home-manager userSettings stylix winapps;
      }
    );
  };
}
