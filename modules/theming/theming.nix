#
#  GTK
#
{
  lib,
  config,
  pkgs,
  host,
  userSettings,
  ...
}: {
  home-manager.users.${userSettings.username} = {
    home = {
      #pointerCursor = {
      #  gtk.enable = true;
      #  name = lib.mkForce "Dracula-cursors";
      #  package = lib.mkForce pkgs.dracula-theme;
      #  size = lib.mkForce 16;
      #  x11 = {
      #    enable = true;
      #    defaultCursor = "Dracula-cursors";
      #  };
      #};
    };

    gtk =
      #lib.mkIf (config.gnome.enable == false)
      {
        # enable = true;
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
        gtk3.extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };
        gtk4.extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };
      };

    #  qt = {
    #    enable = true;
    # #   platformTheme.name = "gtk";
    # #   style = {
    # #     name = "adwaita-dark";
    # #     package = pkgs.adwaita-qt;
    # #   };
    #  };
  };

  # environment.variables = {
  #   QT_QPA_PLATFORMTHEME = "gtk2";
  # };
}
