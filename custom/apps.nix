{
  config,
  pkgs,
  ...
}: let
  # apps from github
  wayvibes = pkgs.callPackage ./apps/wayvibes.nix {};
in {
  environment.systemPackages = with pkgs; [
    wayvibes
  ];
}
