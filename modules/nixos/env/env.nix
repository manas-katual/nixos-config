{
  environment.variables = {
    EDITOR = "nvim";
    #RANGER_LOAD_DEFAULT_RC = "FALSE";
    QT_QPA_PLATFORMTHEME = "qtct";
    QT_QPA_PLATFORM = "wayland";
    #GSETTINGS_BACKEND = "keyfile";
    #DRI_PRIME = "pci-0000_01_00_0";
  };
	environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
