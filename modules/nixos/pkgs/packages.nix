{ config, pkgs, lib, ... }: 

{
  nixpkgs.config = {
    allowUnfree = true;
  };
  
  environment.systemPackages = with pkgs; [
    neovim
    #git
    neofetch
    fastfetch
    #htop
    #brave
    firefox
    #kitty
    wget
    wl-clipboard
    cliphist
    #rofi-wayland
   # hyprpaper

    python3
    python312Packages.pip
    python312Packages.pyaudio
    espeak
    pylint
    
    pamixer
    pavucontrol
    nautilus
    libsForQt5.dolphin
    tree
    vscodium-fhs
    cpu-x
    vesktop
    tgpt
    neovide
    slurp
    grim
    brightnessctl
    spice
    spice-protocol
    spice-gtk
    blueberry
    lxde.lxsession
    unetbootin
    xorg.xhost
    isoimagewriter
    gparted
    mediawriter
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    catppuccin-sddm-corners
    elegant-sddm
    sddm-chili-theme
    radeontop
    glxinfo
    eza
    mpv
    eww
    libnotify
		#fragments
		libsForQt5.ark
		disfetch

		libsForQt5.kdenlive
		glaxnimate
		obs-studio
    davinci-resolve

		discordo
		ripcord
		cinnamon.nemo
		cinnamon.nemo-with-extensions
		bat
		eog
		scrcpy
		acpi
		lan-mouse
		swaynotificationcenter
		
		ripgrep
		fd
		coreutils
		clang
		shellcheck
		luajitPackages.luacheck
    imv
    gcc
    codeblocks
    tldr
    pmbootstrap
    virt-viewer
    tmux
    mission-center

  ] 
   ++ (if (config.programs.hyprland.enable == true) || (config.programs.sway.enable == true) || (config.programs.wayfire.enable == true)
           then [pkgs.rofi-wayland]
         else 
           (if (config.services.xserver.windowManager.dwm.enable == true)
             then [pkgs.rofi]
         else []));

  fonts.packages = with pkgs; [
    intel-one-mono
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    fira-code
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

	programs.adb.enable = true;
	services.acpid.enable = true;
  
}
