{ inputs, nixpkgs, home-manager, userSettings, stylix, ... }:
let
  system = "x86_64-linux";
  lib = nixpkgs.lib;
in
{
  dell = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system userSettings stylix;
      host = {
        hostName = "dell";
      }; 
    };
  modules = [
    ./dell
    ./configuration.nix

    inputs.stylix.nixosModules.stylix
    home-manager.nixosModules.home-manager 
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
  ];
  };
}
