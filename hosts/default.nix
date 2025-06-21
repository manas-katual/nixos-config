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
  ...
}: let
  system = "x86_64-linux";

  lib = nixpkgs.lib;
in {
  # dell inspiron
  dell = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system userSettings;
      host = {
        hostName = "dell";
        mainMonitor = "LVDS-1";
      };
    };
    modules = [
      ./dell
      ./configuration.nix

      inputs.stylix.nixosModules.stylix
      inputs.nur.modules.nixos.default

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
      }
    ];
  };

  # nokia purebook x14
  nokia = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system userSettings;
      host = {
        hostName = "nokia";
        mainMonitor = "eDP-1";
      };
    };
    modules = [
      ./nokia
      ./configuration.nix

      inputs.stylix.nixosModules.stylix
      inputs.nur.modules.nixos.default
      # inputs.jovian-nixos.nixosModules.default

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
      }
    ];
  };

  # hp
  hp = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system userSettings;
      host = {
        hostName = "hp";
        mainMonitor = "LVDS-1";
      };
    };
    modules = [
      ./hp
      ./configuration.nix

      inputs.stylix.nixosModules.stylix
      inputs.nur.modules.nixos.default

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
      }
    ];
  };
}
