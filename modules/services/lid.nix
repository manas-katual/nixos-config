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
    };
  };
}
