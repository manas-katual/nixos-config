{
  pkgs,
  config,
  inputs,
  ...
}: {
  environment.systemPackages =
    [
      (import ./gamemode.nix {inherit pkgs;})
      (import ./screenshot.nix {inherit pkgs;})
      (import ./volume.nix {inherit pkgs inputs;})
      (import ./brightness.nix {inherit pkgs inputs;})
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
