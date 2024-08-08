{ config, pkgs, ... }:
{
  # qt theme
  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;

  # gtk theme
  gtk.enable = true;
  gtk = {    
    font = {
    name = "Intel One Mono";
    size = 12;
    package = pkgs.intel-one-mono;
    };
  }; 


  gtk.theme.package = pkgs.equilux-theme;
  gtk.theme.name = "Equilux-compact";

  gtk.iconTheme.package = pkgs.gruvbox-plus-icons;
  gtk.iconTheme.name = "Gruvbox-Plus-Dark";


	# Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  xdg.configFile = {
  	"gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
  	"gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  	"gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
};

}
