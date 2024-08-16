{ config, lib, options, ... }:

{
  environment.sessionVariables = {
    EDITOR = "nvim";
    #RANGER_LOAD_DEFAULT_RC = "FALSE";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_QPA_PLATFORM = "wayland;xcb";
    #GSETTINGS_BACKEND = "keyfile";
    #DRI_PRIME = "pci-0000_01_00_0";
		NIXOS_OZONE_WL = "1";
  };
}
