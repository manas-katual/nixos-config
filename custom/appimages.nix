{
  config,
  pkgs,
  ...
}: let
  # appimages
  Mechvibes = import ./appimages/mechvibes.nix {inherit pkgs;};
  webos-dev-manager = import ./appimages/webos-dev-manager.nix {inherit pkgs;};
in {
  environment.systemPackages = with pkgs; [
    Mechvibes
    webos-dev-manager
  ];
}
