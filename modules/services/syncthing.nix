{userSettings, ...}: {
  services.syncthing = {
    enable = true;
    openDefaultPorts = true; # Open ports in the firewall for Syncthing
    user = "${userSettings.username}";
    configDir = "/home/${userSettings.username}/.conifg/syncthing";
    settings = {
      devices = {
        "s23" = {id = "FM4G45K-KJOHZUT-72JWPVQ-KJUNR42-R4R6ECG-M3CJ5C5-S6UE3E6-D4SJRAB";};
      };
      folders = {
        "obsidian" = {
          path = "/home/${userSettings.username}/obsidian/sync";
          devices = ["s23"];
          ignorePerms = true;
        };
      };
    };
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
}
