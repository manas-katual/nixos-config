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
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    # Hyprpanel based on ags
    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim distro
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # doom-emacs unstraightened
    # nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";

    # NUR Community Packages
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # youtube terminal
    yt-x.url = "github:Benexl/yt-x";

    # jovian steam
    jovian-nixos.url = "github:Jovian-Experiments/Jovian-NixOS";

    # niri compositor
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ags widgets
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # menu launcher
    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # firefox declaritively
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # spotify
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    # gnome like bar based on ags
    mithril-shell.url = "github:andreashgk/mithril-shell";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    userSettings = {
      username = "manas";
      terminal = "kitty";
      editor = "nvim";
      bar = "hyprpanel";
      theme = "onedark";
      gitUsername = "manas-katual";
      gitEmail = "manaskatual19@gmail.com";
      cpu = "intel";
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
