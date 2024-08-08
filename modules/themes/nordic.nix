{ config, pkgs, ... }:
{

  # Theme GTK
  gtk = {
    enable = true;
    font = {
      name = "Intel One Mono";
      size = 12;
      package = pkgs.intel-one-mono;
    };

theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-nord;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme=1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme=1;
    };
  };

  # Theme QT -> GTK
  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style = {
      name = "Nordic";
      package = pkgs.nordic;
    };
  };

}

