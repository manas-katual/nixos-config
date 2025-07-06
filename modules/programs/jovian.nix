{userSettings, ...}: {
  jovian.steam = {
    enable = true;
    autoStart = true;
    user = "${userSettings.username}";
    desktopSession = "hyprland-uwsm";
  };
}
