{ pkgs, ... }:
{
  nixpkgs.config.packageOverrides =
    pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override {
      enableHybridCodec = true;
    };
  };

  # OpenGL
  hardware.opengl = {

	  # vulkan
    enable = true;
    driSupport = true;
    driSupport32Bit = true;

    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      amdvlk

			# opencl
			rocmPackages.clr.icd
    ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };

	# for Southern Islands (SI i.e. GCN 1) cards
	boot.kernelParams = [ 
		"radeon.si_support=0"
		"amdgpu.si_support=1"
		"video=LVDS-1:1366x768@60"
		"video=HDMI-A-1:1920x1080@30"
	];

  # HIP software
	systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
	services.xserver.videoDrivers = [ "amdgpu" ];


}
