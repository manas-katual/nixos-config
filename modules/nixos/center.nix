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
    #./nixvim/nixvim.nix
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
    #../games/steam.nix
    #../games/games.nix
    ../games/center.nix

    # desktop/window
    ../desktops/hyprland/nix-hyprland.nix
    ../desktops/gnome/gnome.nix
    ../desktops/pantheon/pantheon.nix
    ../desktops/kde/kde.nix
    ../desktops/sway/sway.nix
    ../desktops/dwm/dwm.nix
  ];
}
