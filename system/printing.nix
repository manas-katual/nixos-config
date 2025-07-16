{pkgs, ...}: {
  services = {
    printing = {
      enable = true;
      drivers = [
        # pkgs.hplipWithPlugin
      ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
  environment.systemPackages = with pkgs; [
    # hplip # hp printing drivers
  ];
}
