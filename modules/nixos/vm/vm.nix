{ config, pkgs, ... }:

{

  # QEMU & Booting UEFI
  environment = {
    systemPackages = [ 
      pkgs.qemu
      (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          "$@"
      '')
    ];
  };

  # Libvirt
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
        secureBoot = true;
        tpmSupport = true;
        }).fd];
      };
    };
  };

  # Nested Virtualization
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  # Virt-Manager
  programs.virt-manager.enable = true;


}
