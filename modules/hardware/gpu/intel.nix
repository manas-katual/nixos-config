{
  pkgs,
  userSettings,
  lib,
  ...
}: {
  config = lib.mkIf (userSettings.gpu == "intel") {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vpl-gpu-rt # or intel-media-sdk for QSV
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };
}
