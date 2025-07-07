{
  pkgs,
  lib,
  userSettings,
  ...
}: {
  config = lib.mkIf (userSettings.gpu == "amd") {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          amdvlk
        ];
        extraPackages32 = with pkgs; [
          driversi686Linux.amdvlk # Vulkan driver for 32-bit applications
        ];
      };
    };
    # GUI Tools for AMD GPU Management
    environment.systemPackages = with pkgs; [
      lact # Linux AMDGPU Controller
    ];

    systemd = {
      packages = [pkgs.lact];
      services.lactd.wantedBy = ["multi-user.target"];
    };
  };
}
