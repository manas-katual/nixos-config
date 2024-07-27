{
  imports = [

    # terminals
    #./terminals/alacritty.nix
    ./terminals/kitty.nix

    # cool
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
		./nur.nix
		#./eww/eww.nix
    ./neovim/neovim.nix

    ./waybar/waybar-gruvbox.nix
    ./rofi/rofi-gruvbox.nix
    ./wlogout/wlogout.nix

    # desktops
    ../desktops/hyprland/center.nix
    #../desktops/sway/center.nix
    #../desktops/sway/swayconf.nix
    ../desktops/wayfire/wayfire-config.nix

    # themes
    ./themes/mint.nix
    ./cusrors/google-dot.nix

		

    # games
    ../games/proton.nix
  ];
}
