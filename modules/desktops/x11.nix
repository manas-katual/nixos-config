{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.x11wm.enable) {
    environment = {
      variables = {
      };
      sessionVariables = {
        QT_QPA_PLATFORM = "xcb";
      };
      systemPackages = with pkgs; [
        xclip # Clipboard
        xorg.xev # Event Viewer
        xorg.xkill # Process Killer
        xorg.xrandr # Monitor Settings
        xterm # Terminal
      ];
    };
  };
}
