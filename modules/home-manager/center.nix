{
  imports = [

    # main
    ./git/git.nix
    ./htop/htop.nix
    ./lf/lf.nix
    ./mangohud/mangohud.nix
    #./mako/mako.nix
    #./swaync/swaync-gruvbox.nix
    ./nix-colors/nix-colors.nix
    ./zathura/zathura.nix
		./nur/nur.nix
		#./eww/eww.nix
    #./neovim/neovim.nix
    ./pkgs/packages.nix

    ./waybar/waybar-gruvbox.nix
    ./rofi/rofi-gruvbox.nix
    #./wlogout/wlogout.nix

    # desktops
    #../desktops/hyprland/center.nix
    #../desktops/sway/center.nix
    #../desktops/sway/config.nix
		#../desktops/sway/sway.nix
    #../desktops/wayfire/wayfire-config.nix
    #../desktops/wayfire/wf-shell.nix

    # themes
    ./themes/mint.nix
    ./cursors/google-dot.nix
		

  ];
}
