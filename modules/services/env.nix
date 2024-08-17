{ config, lib, options, ... }:

{
  environment.sessionVariables = {
    EDITOR = "nvim";
    #RANGER_LOAD_DEFAULT_RC = "FALSE";
    #QT_QPA_PLATFORMTHEME = "gtk";
    #QT_QPA_PLATFORM = "wayland;xcb";
		#QT_STYLE_OVERRIDE = "adwaita-dark";
    #GSETTINGS_BACKEND = "keyfile";
    #DRI_PRIME = "pci-0000_01_00_0";
		#NIXOS_OZONE_WL = "1";
  };
	

}
