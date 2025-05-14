{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.laptop.enable && config.gnome.enable == false) {
    services = {
      logind = {
        lidSwitch = "suspend";
        lidSwitchExternalPower = "lock";
        lidSwitchDocked = "ignore";
      };

      # This tells systemd to lock the session before sleeping
      # systemd.extraConfig = ''
      #   HandleLidSwitch=suspend
      #   HandleLidSwitchExternalPower=lock
      #   HandleLidSwitchDocked=ignore
      # '';
    };
  };
}
