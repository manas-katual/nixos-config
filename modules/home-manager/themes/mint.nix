{ config, pkgs, ... }:

{
  
  # qt theme
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  # gtk theme
  gtk = {    
    enable = true;
    font = {
      name = "Intel One Mono";
      size = 14;
      package = pkgs.intel-one-mono;
    };
    theme = {
      package = pkgs.mint-themes;
      name = "Mint-Y-Dark-Teal";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  }; 

	# Now symlink the `~/.config/gtk-4.0/` folder declaratively:
#  xdg.configFile = {
#  	"gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
#  	"gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
#  	"gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
#};

}

