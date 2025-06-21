{host, ...}: {
  networking = {
    hostName = "${host.hostName}"; # Define your hostname.
    networkmanager.enable = true; # network manager systemd
    #wireless.enable = true; # Enables wireless support via wpa_supplicant.
  };
}
