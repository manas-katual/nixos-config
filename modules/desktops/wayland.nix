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
      systemPackages = with pkgs; [
        wev # Event Viewer
        wl-clipboard # Clipboard
        wlr-randr # Monitor Settings
        xdg-desktop-portal-wlr # Wayland portal
        xwayland # X for Wayland
        networkmanagerapplet
        blueman
      ];
    };
  };
}
