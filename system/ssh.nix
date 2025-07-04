{
  services = {
    openssh = {
      enable = true;
    };
  };
  programs.ssh = {
    extraConfig = "
      Host homelab
        Hostname 192.168.0.50
        Port 22
        User dev
    ";
  };
}
