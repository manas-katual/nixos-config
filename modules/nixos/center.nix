{ config, lib, options, ... }:

{
  imports = [
    ./broadcom/broadcom.nix
    ./sound/sound.nix
    ./gpu/intel-amd.nix
    ./env/env.nix
    ./zram/zram.nix
    ./vm/vm.nix
    ./essential/essential.nix
    ./appimage/appimage.nix
    ./pkgs/packages.nix
		./waydroid/waydroid.nix
		./nur/nur.nix
    #./stylix/stylix.nix
		./flatpak/flatpak.nix
    ./pcmanfm/pcmanfm.nix
    ./display-managers/sddm.nix
    ./wine/wine.nix

    # distrobox
    ./distrobox-podman/distrobox-podman.nix

    # bootloader
    #./bootloader/systemd.nix
    ./bootloader/grub.nix
    #./grub-themes/grub-theme.nix
    #./appimage/app.nix

    # games
    ../games/games.nix
    
    # terminals
    ./terminals/kitty.nix
    
    # shell
    ../shell/bash.nix
    
    # editors
    ../editors/emacs/emacs.nix
    ../editors/nixvim/nixvim.nix

    # desktop/window
    ../desktops/hyprland/hyprland.nix
    ../desktops/gnome/gnome.nix
    ../desktops/pantheon/pantheon.nix
    ../desktops/kde/kde.nix
    ../desktops/sway/sway.nix
    ../desktops/dwm/dwm.nix
		../desktops/wayfire/wayfire.nix

    ../home-manager/swaync/swaync-gruvbox.nix 
    ./wlogout/wlogout.nix 
  
  ]; 
  #++
  #  (if (config.programs.hyprland.enable == true) || (config.programs.sway.enable == true) || (config.programs.wayfire.enable == true)
  #   then [ ../home-manager/swaync/swaync-gruvbox.nix ]
  #  else []);
  
}
