{ config, pkgs, userSettings, ... }:

{

  # QEMU & Booting UEFI
  environment = {
    systemPackages = [ 
      pkgs.qemu
			pkgs.virtiofsd			
      pkgs.virt-viewer
      pkgs.swtpm
      pkgs.virglrenderer
      pkgs.OVMF
      (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          "$@" ''
      )
    ];
  };

  # Libvirt
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };

  # Nested virtualization
  #boot.extraModprobeConfig = "options kvm_intel nested=1";

  # Virt-Manager
  programs.virt-manager.enable = true;

  # GPU Passthrough
  boot.kernelParams = [
    "intel_iommu=on"
    "iommu=pt"
  ];

}
