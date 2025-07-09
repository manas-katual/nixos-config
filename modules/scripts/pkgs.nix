{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages =
    [
      (import ./gamemode.nix {inherit pkgs;})
      (import ./screenshot.nix {inherit pkgs;})
    ]
    ++ (
      if config.hyprland.enable
      then [
        (import ./hypr_window.nix {inherit pkgs;})
      ]
      else if config.sway.enable
      then [
        (import ./sway_window.nix {inherit pkgs;})
      ]
      else []
    );
}
