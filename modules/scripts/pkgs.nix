{pkgs, ...}: {
  environment.systemPackages = [
    (import ./gamemode.nix {inherit pkgs;})
    (import ./screenshot.nix {inherit pkgs;})
    (import ./window_class.nix {inherit pkgs;})
  ];
}
