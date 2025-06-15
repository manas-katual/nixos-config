{
  config,
  pkgs,
  lib,
  userSettings,
  ...
}:
with lib; {
  config = mkIf (config.hyprland.enable) {
    wlwm.enable = true;
    home-manager.users.${userSettings.username} = {
      wayland.windowManager.hyprland.settings = {
        windowrule = [];
        windowrulev2 = [
          "workspace 2, class:^(neovide|Emacs)$"
          "workspace 3, class:^(google-chrome|firefox)$"
          "workspace 4, class:^(pcmanfm|[Tt]hunar)$"
          "workspace 8, class:^(.virt-manager-wrapped)$"

          # "opacity 0.9, class:^(kitty)"
          #"tile,initialTitle:^WPS.*"

          "tag +file-manager, class:^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$"
          "tag +terminal, class:^(Alacritty|kitty|kitty-dropterm)$"
          "tag +browser, class:^(Brave-browser(-beta|-dev|-unstable)?)$"
          "tag +browser, class:^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$"
          "tag +browser, class:^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$"
          "tag +browser, class:^([Tt]horium-browser|[Cc]achy-browser)$"
          "tag +projects, class:^(codium|codium-url-handler|VSCodium)$"
          "tag +projects, class:^(VSCode|code-url-handler)$"
          "tag +im, class:^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$"
          "tag +im, class:^([Ff]erdium)$"
          "tag +im, class:^([Ww]hatsapp-for-linux)$"
          "tag +im, class:^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$"
          "tag +im, class:^(teams-for-linux)$"
          "tag +games, class:^(gamescope)$"
          "tag +games, class:^(steam_app_\d+)$"
          "tag +gamestore, class:^([Ss]team)$"
          "tag +gamestore, title:^([Ll]utris)$"
          "tag +gamestore, class:^(com.heroicgameslauncher.hgl)$"
          "tag +settings, class:^(gnome-disks|wihotspot(-gui)?)$"
          "tag +settings, class:^([Rr]ofi)$"
          "tag +settings, class:^(file-roller|org.gnome.FileRoller)$"
          "tag +settings, class:^(nm-applet|nm-connection-editor|blueman-manager)$"
          "tag +settings, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
          "tag +settings, class:^(nwg-look|qt5ct|qt6ct|[Yy]ad)$"
          "tag +settings, class:(xdg-desktop-portal-gtk)"
          "tag +settings, class:(.blueman-manager-wrapped)"
          "tag +settings, class:(nwg-displays)"
          "move 72% 7%,title:^(Picture-in-Picture)$"
          "center, class:^([Ff]erdium)$"
          "float, class:^([Ww]aypaper)$"
          "center, class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
          "center, class:([Tt]hunar), title:negative:(.*[Tt]hunar.*)"
          "center, title:^(Authentication Required)$"
          "idleinhibit fullscreen, class:^.*$"
          "idleinhibit fullscreen, title:^.*$"
          "idleinhibit fullscreen, fullscreen:1"
          "float, tag:settings*"
          "float, class:^([Ff]erdium)$"
          "float, title:^(Picture-in-Picture)$"
          "float, class:^(mpv|com.github.rafostar.Clapper)$"
          "float, title:^(Authentication Required)$"
          "float, class:(codium|codium-url-handler|VSCodium), title:negative:(.*codium.*|.*VSCodium.*)"
          "float, class:^(com.heroicgameslauncher.hgl)$, title:negative:(Heroic Games Launcher)"
          "float, class:^([Ss]team)$, title:negative:^([Ss]team)$"
          "float, class:([Tt]hunar), title:negative:(.*[Tt]hunar.*)"
          "float, initialTitle:(Add Folder to Workspace)"
          "float, initialTitle:(Open Files)"
          "float, initialTitle:(wants to save)"
          "size 70% 60%, initialTitle:(Open Files)"
          "size 70% 60%, initialTitle:(Add Folder to Workspace)"
          "size 70% 70%, tag:settings*"
          "size 60% 70%, class:^([Ff]erdium)$"
          "opacity 1.0 1.0, tag:browser*"
          "opacity 0.9 0.8, tag:projects*"
          "opacity 0.94 0.86, tag:im*"
          "opacity 0.9 0.8, tag:file-manager*"
          "opacity 0.8 0.7, tag:terminal*"
          "opacity 0.8 0.7, tag:settings*"
          "opacity 0.8 0.7, class:^(gedit|org.gnome.TextEditor|mousepad)$"
          "opacity 0.9 0.8, class:^(seahorse)$ # gnome-keyring gui"
          "opacity 0.95 0.75, title:^(Picture-in-Picture)$"
          "pin, title:^(Picture-in-Picture)$"
          "keepaspectratio, title:^(Picture-in-Picture)$"
          "noblur, tag:games*"
          "fullscreen, tag:games*"
        ];
      };
    };
  };
}
