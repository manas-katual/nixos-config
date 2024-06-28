{ config, pkgs, inputs, ... }:
{
	services.flatpak.enable = true;

	imports = [
		inputs.nix-flatpak.nixosModules.nix-flatpak
	];

	services.flatpak.packages = [
		"io.mrarm.mcpelauncher"
		"com.github.tchx84.Flatseal"
		"org.polymc.PolyMC"
  ];

	xdg.portal.enable = true; # for flatpak
	
	# run this in terminal to view flatpaks in rofi
	#export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
}
