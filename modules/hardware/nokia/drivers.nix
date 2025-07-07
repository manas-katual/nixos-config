{config, ...}: {
  boot.initrd.kernelModules = ["i915"];
  boot.kernelModules = ["kvm-intel"];
  services.xserver.videoDrivers =
    if (config.x11wm.enable)
    then [
      "modesetting"
    ]
    else [];

  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};

  networking.networkmanager.wifi.powersave = false;
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
}
