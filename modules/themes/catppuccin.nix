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
      name = "Catppuccin-Macchiato-Compact-Sky-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["sky"];
				variant = "macchiato";
				size = "compact";
        tweaks = [ "rimless" "black" ];
      };
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
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

	# Now symlink the `~/.config/gtk-4.0/` folder declaratively:
 	xdg.configFile = {
  	"gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
  	"gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  	"gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
};

}


