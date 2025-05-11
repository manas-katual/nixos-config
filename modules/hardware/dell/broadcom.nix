{ config, pkgs, ... }:

{

  # For broadcom wifi
  boot.initrd.kernelModules = [ "wl" ];
  boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  boot.blacklistedKernelModules = [ "b43" "ssbbrcmfmac" "brcmsmac" ];


  # For broadcom bluetooth
  hardware.enableAllFirmware = true;

  #environment.systemPackages = [
  #  pkgs.linux-firmware
  #];


}
