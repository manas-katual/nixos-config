{
  imports = [

    # terminals
    ./terminals/alacritty.nix
    #./terminals/kitty.nix

    # cool
    ./git/git.nix
    #./themes/gtk-qt.nix
    ./themes/mint.nix
    ./themes/cursor.nix
    ./htop/htop.nix
    ./shells/bash.nix
    ./lf/lf.nix
    #./mangohud/mangohud.nix
    #./mako/mako.nix
		./swaync/swaync3.nix
    ./nix-colors/nix-colors.nix
    ./zathura/zathura.nix
    ./vm/vm.nix
    ./emacs/emacs.nix
		./nur.nix
		./eww/eww.nix
    ./neovim/neovim.nix

    # desktops
		../desktops/hyprland/center.nix
		

    # games
    ../games/proton.nix
  ];
}
