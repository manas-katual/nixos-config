{pkgs, ...}: {
  environment.systemPackages = [
    (import ./screenshot.nix {inherit pkgs;})
    (import ./gamemode.nix {inherit pkgs;})
  ];
}
