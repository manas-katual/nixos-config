{ config, pkgs, ... }:

{
  
  # Basic setup
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # for Southern Islands (SI i.e. GCN 1) cards
  boot.kernelParams = [ "radeon.si_support=0" "amdgpu.si_support=1" ];

  # AMDVLK
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
  ];
  # For 32 bit applications 
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  # GUI Tools
  environment.systemPackages = with pkgs; [                                                                               lact                                                                                                                ];                                                                                                                                                                                                                     
  systemd.services.lactd = {
    description = "AMDGPU Control Daemon";
    enable = true;  
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };
    wantedBy = ["multi-user.target"];
  };

}
