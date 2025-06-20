{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    soundwireserver # to listen audio from pc to mobile
  ];
  networking.firewall.allowedTCPPorts = [59010]; # for soundwire
  networking.firewall.allowedUDPPorts = [59010]; # for soundwire
}
