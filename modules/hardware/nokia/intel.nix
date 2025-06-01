{pkgs, ...}: {
  boot.initrd.kernelModules = ["i915"];
  boot.kernelModules = ["kvm-intel"];
  services.xserver.videoDrivers = [
    "i915"
    "intel"
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt # or intel-media-sdk for QSV
      intel-media-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};
}
