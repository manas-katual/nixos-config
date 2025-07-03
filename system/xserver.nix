{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.x11wm.enable) {
    services.xserver = {
      enable = true;
      xkb = {
        layout = "in";
        variant = "eng";
      };
    };
  };
}
