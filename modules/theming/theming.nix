#
#  gtk & qt
#
{
  lib,
  config,
  pkgs,
  userSettings,
  ...
}: {
  home-manager.users.${userSettings.username} = {
    gtk =
      lib.mkIf (config.gnome.enable == false)
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

    qt = {
      enable = true;
    };
  };
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum";
  };
}
