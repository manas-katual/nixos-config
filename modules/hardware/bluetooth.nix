{
  pkgs,
  userSettings,
  config,
  ...
}: {
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        AutoEnable = true;
        ControllerMode = "bredr";
      };
    };
  };
  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = ["network.target" "sound.target"];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  environment.systemPackages = with pkgs;
    [
    ]
    ++ (
      if (!config.sway.enable && userSettings.style == "waybar-oglo" || userSettings.style == "waybar-jerry" || userSettings.style == "waybar-cool" || userSettings.style == "waybar-macos" || userSettings.style == "waybar-nekodyke" || userSettings.style == "waybar-ddubs")
      then [
        blueman
      ]
      else []
    );

  services.blueman.enable =
    if !config.sway.enable && userSettings.style == "waybar-oglo" || userSettings.style == "waybar-jerry" || userSettings.style == "waybar-cool" || userSettings.style == "waybar-macos" || userSettings.style == "waybar-nekodyke" || userSettings.style == "waybar-ddubs"
    then true
    else false;
}
