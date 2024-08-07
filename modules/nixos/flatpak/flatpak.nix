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
    "org.freedownloadmanager.Manager"
    "org.jdownloader.JDownloader"
  ];

  # auto updates
  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly"; # Default value
  };

	xdg.portal.enable = true; # for flatpak
	xdg.portal.wlr.enable = true;
  xdg.portal.configPackages = [ pkgs.gnome.gnome-session ];
	
	# run this in terminal to view flatpaks in rofi after fresh install of nixos
	#export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
}
