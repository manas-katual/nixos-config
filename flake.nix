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

    # neovim distro
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # stylix
    #stylix.url = "github:danth/stylix";

    # nix colors
    nix-colors.url = "github:misterio77/nix-colors";

		# nur
		nur.url = github:nix-community/NUR;

		# flatpak
		nix-flatpak.url = "github:gmodena/nix-flatpak";

		# hyprland
		hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # hyprland plugins
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # pyprland
    pyprland.url = "github:hyprland-community/pyprland";

		# grub-themes
		nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";

  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs:

    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      
      userSettings = {
			  username = "smaalks";
			  host = "hyprdell";
        desktop = "hyprland";
      };

    in {
    # nixos - system hostname
    nixosConfigurations.${userSettings.host} = lib.nixosSystem {
      specialArgs = {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        inherit inputs system;
        inherit userSettings;
      };
      modules = [
        ./hosts/dell/configuration.nix
				home-manager.nixosModules.home-manager {
	  			home-manager.useGlobalPkgs = true;
	  			home-manager.useUserPackages = true;
	  			home-manager.users.${userSettings.username} = import ./hosts/dell/home.nix;
	  		  home-manager.extraSpecialArgs = {
            inherit inputs; 
            inherit userSettings;
          };
				}
      ];
    };
  };
}
