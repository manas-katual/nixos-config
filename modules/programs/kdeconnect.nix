{userSettings, ...}: {
  programs = {
    kdeconnect = {
      enable = true;
    };
  };

  home-manager.users.${userSettings.username} = {
    services.kdeconnect = {
      enable = true;
      indicator = true;
    };
  };

  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
}
