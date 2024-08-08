{

  # Fix USB sticks not mounting or being listed:
  services.devmon.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # dbus 
  services.dbus.enable = true;

  # dconf
  programs.dconf.enable = true;

}
