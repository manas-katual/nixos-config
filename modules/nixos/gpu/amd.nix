{ config, pkgs, ... }:
{
  boot.initrd.kernelModules = [ "amdgpu" ]; 
  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.kernelParams = [ "radeon.si_support=0" "amdgpu.si_support=1" ];
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  hardware.opengl.driSupport = true; # This is already enabled by default
  hardware.opengl.driSupport32Bit = true; # For 32 bit applications
}
