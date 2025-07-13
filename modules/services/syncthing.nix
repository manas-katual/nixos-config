{
  userSettings,
  pkgs,
  ...
}: {
  # environment.systemPackages = with pkgs; [
  #   syncthingtray-minimal
  # ];
  services.syncthing = {
    enable = true;
    openDefaultPorts = true; # Open ports in the firewall for Syncthing
    user = "${userSettings.username}";
    group = "users";
    configDir = "/home/${userSettings.username}/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "s23" = {
          id = "FM4G45K-KJOHZUT-72JWPVQ-KJUNR42-R4R6ECG-M3CJ5C5-S6UE3E6-D4SJRAB";
        };
      };
      folders = {
        "klexu-gdfa5" = {
          label = "obsidian";
          path = "/home/${userSettings.username}/Documents/obsidian/sync";
          devices = ["s23"];
        };
      };
    };
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
}
