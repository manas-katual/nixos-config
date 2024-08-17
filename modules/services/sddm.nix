{ pkgs, config, ... }:

let
  background-package = pkgs.stdenvNoCC.mkDerivation {
    name = "background-image";
    src = ../wallpapers;
    dontUnpack = true;
    installPhase = ''
      cp $src/nord_roads.png $out
    '';
  };
in
{
  
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.sddm;
    autoNumlock = true;
    #wayland.enable = true; # after enabling this autoNumlock doesn't work
    #theme = "sddm-astronaut-theme";
    theme = "sugar-dark";
    #theme = "catppuccin-sddm-corners";
    #theme = "Elegant-sddm";
    #theme = "sddm-chili";
  };

	environment.systemPackages = with pkgs; [
		libsForQt5.qt5.qtquickcontrols2   
		libsForQt5.qt5.qtgraphicaleffects
		sddm-astronaut
		sddm-sugar-dark
    (
      pkgs.writeTextDir "share/sddm/themes/sugar-dark/theme.conf.user" ''
        [General]
        background = ${background-package}
      ''
    )
		catppuccin-sddm-corners
		elegant-sddm
		sddm-chili-theme
	];

  
}
