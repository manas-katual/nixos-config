{ pkgs, ... }: 
{
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  services.spice-webdavd.enable = true;

  programs.virt-manager = {
    enable = true;
  };

	environment.systemPackages = with pkgs; [
		virtiofsd
	];
}

