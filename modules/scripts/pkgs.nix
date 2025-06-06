{pkgs, ...}: {
  environment.systemPackages = [
    (import ./gamemode.nix {inherit pkgs;})
    (import ./screenshot.nix {inherit pkgs;})
  ];
}
