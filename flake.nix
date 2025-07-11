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

    # doom-emacs unstraightened
    # nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";

    # firefox declaritively
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # gnome like bar based on ags
    mithril-shell = {
      url = "github:andreashgk/mithril-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # niri compositor
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NUR Community Packages
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim distro
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # spotify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # stylix
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    walls = {
      url = "git+https://codeberg.org/manas-katual/walls";
      flake = false;
    };

    # youtube terminal
    yt-x = {
      url = "github:Benexl/yt-x";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    userSettings = {
      username = "manas";
      gitUsername = "manas-katual";
      gitEmail = "manaskatual19@gmail.com";
      terminal = "kitty";
      editor = "nvim";
      desktop = "hyprland";
      style = "waybar-macos";
      theme = "catppuccin-macchiato";
      cpu = "intel";
      gpu = "intel";
      gaming = "off";
      file-manager = "thunar";
    };
  in {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager userSettings;
      }
    );
  };
}
