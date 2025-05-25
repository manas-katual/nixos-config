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
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    # niri
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ags
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # chaotic
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    mithril-shell.url = "github:andreashgk/mithril-shell";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    stylix,
    nvf,
    # hyprpanel,
    nur,
    jovian-nixos,
    niri,
    ags,
    chaotic,
    astal,
    anyrun,
    ...
  }: let
    userSettings = {
      username = "manas";
      #host = "dell";
      terminal = "kitty";
      editor = "nvim";
      bar = "hyprpanel";
      theme = "solarized-dark";
      gitUsername = "manas-katual";
      gitEmail = "manaskatual19@gmail.com";
      cpu = "intel";
    };
  in {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager userSettings stylix nvf nur jovian-nixos niri ags chaotic astal anyrun;
      }
    );
  };
}
