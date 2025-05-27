#
#  These are the different profiles that can be used when building NixOS.
#
#  flake.nix
#   └─ ./hosts
#       ├─ default.nix *
#       ├─ configuration.nix
#       └─ ./<host>.nix
#           └─ default.nix
#
{
  inputs,
  nixpkgs,
  home-manager,
  userSettings,
  stylix,
  nvf,
  nur,
  jovian-nixos,
  niri,
  ags,
  chaotic,
  astal,
  anyrun,
  ...
}: let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in {
  # dell inspiron
  dell = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system userSettings stylix nvf nur jovian-nixos chaotic;
      host = {
        hostName = "dell";
        mainMonitor = "LVDS-1";
      };
    };
    modules = [
      ./dell
      ./configuration.nix

      inputs.stylix.nixosModules.stylix
      # inputs.nvf.nixosModules.default
      inputs.nur.modules.nixos.default
      inputs.jovian-nixos.nixosModules.default
      inputs.chaotic.nixosModules.default

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };

  # nokia purebook x14
  nokia = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system userSettings stylix nvf nur jovian-nixos chaotic astal anyrun;
      host = {
        hostName = "nokia";
        mainMonitor = "eDP-1";
      };
    };
    modules = [
      ./nokia
      ./configuration.nix

      inputs.stylix.nixosModules.stylix
      # inputs.nvf.nixosModules.default
      inputs.nur.modules.nixos.default
      inputs.jovian-nixos.nixosModules.default
      inputs.chaotic.nixosModules.default
      {environment.systemPackages = [anyrun.packages.${system}.anyrun];}

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        # home-manager.extraSpecialArgs = {inherit system pkgs;};
        nixpkgs.overlays = [
          inputs.hyprpanel.overlay
          inputs.niri.overlays.niri
        ];
      }
    ];
  };

  # hp
  hp = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system userSettings stylix nvf nur jovian-nixos chaotic astal anyrun;
      host = {
        hostName = "hp";
        mainMonitor = "eDP-1";
      };
    };
    modules = [
      ./nokia
      ./configuration.nix

      inputs.stylix.nixosModules.stylix
      # inputs.nvf.nixosModules.default
      inputs.nur.modules.nixos.default
      inputs.jovian-nixos.nixosModules.default
      inputs.chaotic.nixosModules.default
      {environment.systemPackages = [anyrun.packages.${system}.anyrun];}

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        # home-manager.extraSpecialArgs = {inherit system pkgs;};
        nixpkgs.overlays = [
          inputs.hyprpanel.overlay
          inputs.niri.overlays.niri
        ];
      }
    ];
  };
}
