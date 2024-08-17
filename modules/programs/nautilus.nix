{ pkgs, config, lib, ... }:

{
	
	environment = {
		pathsToLink = [ "share/thumbnailers" ];
		systemPackages = with pkgs; [
		nautilus
		libheif
		libheif.out
	];
	};

	programs.nautilus-open-any-terminal = {
		enable = true;
		terminal = "kitty";
	};

	services.gnome.sushi.enable = true;

	
}
