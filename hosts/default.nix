{ inputs, nixpkgs, home-manager, userSettings, stylix, winapps, ... }:
let
  system = "x86_64-linux";
  lib = nixpkgs.lib;
in
{
  dell = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system userSettings stylix winapps;
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

          (
            { pkgs, ... }:
            {
              environment.systemPackages = [
                winapps.packages.${system}.winapps
                winapps.packages.${system}.winapps-launcher # optional
              ];
            }
          )
  ];
  };
}
