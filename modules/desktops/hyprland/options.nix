{lib, ...}:
with lib; {
  options = {
    hyprland = {
      # Condition if host uses an hyprland window manager
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
}
