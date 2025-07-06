{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.wlwm.enable) {
    environment = {
      variables = {
      };
      sessionVariables = {
        QT_QPA_PLATFORM = "wayland";
      };
      systemPackages = with pkgs;
        [
          wev # Event Viewer
          wl-clipboard # Clipboard
          wlr-randr # Monitor Settings
        ]
        ++ (
          if !config.hyprland.enable || !config.cosmic.enable
          then [
            pkgs.xdg-desktop-portal-wlr
            xwayland
          ]
          else []
        );
    };
  };
}
