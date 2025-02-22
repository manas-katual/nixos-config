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

{ inputs, nixpkgs, home-manager, userSettings, stylix, nvf, hyprpanel, nur, ... }:
let
  system = "x86_64-linux";
  lib = nixpkgs.lib;
in
{
  dell = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system userSettings stylix nvf hyprpanel nur;
      host = {
        hostName = "dell";
	      mainMonitor = "LVDS-1";
      }; 
    };
    modules = [
      ./dell
      ./configuration.nix

      inputs.stylix.nixosModules.stylix
      inputs.nvf.nixosModules.default
      inputs.nur.modules.nixos.default

      home-manager.nixosModules.home-manager 
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        nixpkgs.overlays = [ inputs.hyprpanel.overlay ]; # needed for hyprpanel
      }
    ];
  };
}
