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
        QT_QPA_PLATFORM = "wayland;xcb";
        NIXOS_OZONE_WL = "1";
        NIXPKGS_ALLOW_UNFREE = "1";
        XDG_SESSION_TYPE = "wayland";
        GDK_BACKEND = "wayland,x11";
        CLUTTER_BACKEND = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        SDL_VIDEODRIVER = "x11";
        MOZ_ENABLE_WAYLAND = "1";
        GDK_SCALE = "1";
        QT_SCALE_FACTOR = "1";
        EDITOR = "nvim";
      };
      systemPackages = with pkgs;
        [
          wev # Event Viewer
          wl-clipboard # Clipboard
          wlr-randr # Monitor Settings
        ]
        ++ (
          if config.sway.enable
          then [xdg-desktop-portal-wlr]
          else []
        )
        ++ (
          if !config.hyprland.enable && !config.cosmic.enable && !config.sway.enable
          then [xdg-desktop-portal-wlr xwayland]
          else []
        );
    };
  };
}
