{lib, ...}:
with lib; {
  options = {
    sway = {
      # Condition if host uses an sway window manager
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
}
