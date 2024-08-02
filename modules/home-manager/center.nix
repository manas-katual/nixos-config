{
  imports = [

    # terminals
    #./terminals/alacritty.nix
    ./terminals/kitty.nix

    # main
    ./git/git.nix
    ./htop/htop.nix
    ./shells/bash.nix
    ./lf/lf.nix
    ./mangohud/mangohud.nix
    #./mako/mako.nix
    ./swaync/swaync-gruvbox.nix
    ./nix-colors/nix-colors.nix
    ./zathura/zathura.nix
    ./vm/vm.nix
    ./emacs/emacs.nix
		./nur/nur.nix
		#./eww/eww.nix
    ./neovim/neovim.nix
    ./pkgs/packages.nix

    ./waybar/waybar-gruvbox.nix
    ./rofi/rofi-gruvbox.nix
    ./wlogout/wlogout.nix

    # desktops
    ../desktops/hyprland/center.nix
    #../desktops/sway/center.nix
    #../desktops/sway/config.nix
    ../desktops/wayfire/wayfire-config.nix

    # themes
    ./themes/mint.nix
    ./cursors/google-dot.nix

		

    # games
    ../games/proton.nix
  ];
}
