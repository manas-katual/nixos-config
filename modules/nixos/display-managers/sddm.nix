{ pkgs, config, ... }:

{
  
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.sddm;
    autoNumlock = true;
    #wayland.enable = true;
    theme = "catppuccin-sddm-corners";
    #theme = "Elegant-sddm";
    #theme = "sddm-chili";
  };
  
}
