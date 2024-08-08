{ pkgs, config, ... }:

{
  
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.sddm;
    autoNumlock = true;
    #wayland.enable = true; # after enabling this autoNumlock doesn't work
    theme = "catppuccin-sddm-corners";
    #theme = "Elegant-sddm";
    #theme = "sddm-chili";
  };
  
}
