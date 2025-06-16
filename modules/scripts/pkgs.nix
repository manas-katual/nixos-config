{pkgs, ...}: {
  environment.systemPackages = [
    (import ./gamemode.nix {inherit pkgs;})
    (import ./screenshot.nix {inherit pkgs;})
    (import ./waybar-kill.nix {inherit pkgs;})
  ];
}
