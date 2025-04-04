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

    # Official Hyprland Flake
    #hyprland = {
    #  url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    #};

    # Hyprspace
    #hyprspace = {
    #  url = "github:KZDKM/Hyprspace";
    #  inputs.hyprland.follows = "hyprland";
    #};

    # Hyprpanel
    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nvf neovim
    nvf.url = "github:notashelf/nvf";

    # doom-emacs unstraightened
    # nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";

    # nur
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # youtube terminal
    yt-x.url = "github:Benexl/yt-x";

    # jovian steam
    jovian-nixos.url = "github:Jovian-Experiments/Jovian-NixOS";

  };

  outputs = inputs@ { self, nixpkgs, home-manager, stylix, nvf, hyprpanel, nur, jovian-nixos, ... }:

    let
      userSettings = {
        username = "manas";
        #host = "dell";
        terminal = "kitty";
        editor = "nvim";
        bar = "waybar";
        theme = "gruvbox-dark-hard";
        gitUsername = "manas-katual";
        gitEmail = "manaskatual19@gmail.com";
      };

    in {
      nixosConfigurations = (
        import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager userSettings stylix nvf hyprpanel nur jovian-nixos;
        }
      );
    };
}
