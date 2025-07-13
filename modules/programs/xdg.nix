{
  pkgs,
  userSettings,
  lib,
  config,
  ...
}: {
  home-manager.users.${userSettings.username} = {
    xdg = {
      enable = true;
      mime.enable = true;
      mimeApps = lib.mkIf (config.gnome.enable == false) {
        enable = true;
        defaultApplications = {
          "image/jpeg" = ["image-roll.desktop" "feh.desktop"];
          "image/png" = ["image-roll.desktop"];
          "text/plain" = "nvim.desktop";
          "text/html" = "nvim.desktop";
          "text/csv" = "nvim.desktop";
          "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop" "google-chrome.desktop" "firefox.desktop" "wps-office-pdf.desktop"];
          "application/zip" = "org.gnome.FileRoller.desktop";
          "application/x-tar" = "org.gnome.FileRoller.desktop";
          "application/x-bzip2" = "org.gnome.FileRoller.desktop";
          "application/x-gzip" = "org.gnome.FileRoller.desktop";
          "x-scheme-handler/http" = ["google-chrome.desktop" "firefox.desktop"];
          "x-scheme-handler/https" = ["google-chrome.desktop" "firefox.desktop"];
          "x-scheme-handler/about" = ["google-chrome.desktop" "firefox.desktop"];
          "x-scheme-handler/unknown" = ["google-chrome.desktop" "firefox.desktop"];
          "audio/mp3" = "mpv.desktop";
          "audio/x-matroska" = "mpv.desktop";
          "video/webm" = "mpv.desktop";
          "video/mp4" = "mpv.desktop";
          "video/x-matroska" = "mpv.desktop";
          "inode/directory" = "${userSettings.file-manager}.desktop";
        };
      };
      portal = lib.mkIf (!config.gnome.enable && !config.cosmic.enable) {
        enable = true;
        extraPortals =
          if config.hyprland.enable
          then [pkgs.xdg-desktop-portal-hyprland]
          else if config.sway.enable
          then [pkgs.xdg-desktop-portal-wlr]
          else [];
        configPackages =
          if config.hyprland.enable
          then [pkgs.hyprland]
          else [];
      };
    };
  };
}
