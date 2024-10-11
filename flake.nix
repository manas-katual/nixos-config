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
    stylix.url = "github:danth/stylix";

    # nix colors
    nix-colors.url = "github:misterio77/nix-colors";

		# nur
		nur.url = "github:nix-community/NUR";

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

		# firefox addons
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # spotify modified
		spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # zen browser
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    
    # Emacs Overlays
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      flake = false;
    };

    # Nix-Community Doom Emacs
    doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.emacs-overlay.follows = "emacs-overlay";
    };

		# cosmic
		nixpkgs.follows = "nixos-cosmic/nixpkgs"; 
        nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

  };

  outputs = { self, nixpkgs, home-manager, nur, nixos-cosmic, ... }@inputs:

    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      
      userSettings = {
			  username = "smaalks";
			  host = "hyprdell";
				location = "$HOME/setup";
        desktop = "wayfire";
				rofi = "mac";
        theme = "gruvbox-dark-medium";
      };

    in {
    # nixos - system hostname
    nixosConfigurations.${userSettings.host} = lib.nixosSystem {
      specialArgs = {
        inherit inputs system; 
        inherit userSettings;
      };
      modules = [
        ./hosts/dell/configuration.nix
         {
            nix.settings = {
      substituters = [ "https://cosmic.cachix.org/" ];
      trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
        }
         nixos-cosmic.nixosModules.default
				
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
