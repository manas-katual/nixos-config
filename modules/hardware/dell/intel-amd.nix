{ config, pkgs, ... }:

{
  # Enable graphics support
  hardware = {
   graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
	amdvlk
    ];
    extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk # Vulkan driver for 32-bit applications
    ];
};
};
  # AMD GPU settings for Southern Islands (SI) GPUs
  boot.kernelParams = [
    "radeon.si_support=0" # Disable support for the radeon driver for SI GPUs
    "amdgpu.si_support=1" # Enable support for the amdgpu driver for SI GPUs
  ];

  # GUI Tools for AMD GPU Management
  environment.systemPackages = with pkgs; [
    lact # Linux AMDGPU Controller
  ];

  systemd = {
    packages = [ pkgs.lact ];
    services.lactd.wantedBy = ["multi-user.target"];
  };

  # Intel GPU configuration
  services.xserver.videoDrivers = [ "modesetting" "amdgpu" ]; # Recommended for Intel GPUs
  boot.initrd.kernelModules = [ "amdgpu" ];

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
  
}

