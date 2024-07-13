{ config, pkgs, ... }: 

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
    hyprpaper
    hypridle
    hyprlock
    rofi-wayland

    python3
    python312Packages.pip
    python312Packages.pyaudio
    espeak
    pylint
    
    pamixer
    pavucontrol
    gnome.nautilus
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
    pcmanfm
		lxmenu-data
		shared-mime-info
		fragments
		libsForQt5.ark
		disfetch

		libsForQt5.kdenlive
		glaxnimate
		obs-studio

		discordo
		ripcord
		cinnamon.nemo
		cinnamon.nemo-with-extensions
		bat
		gnome.eog
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

  ];

  fonts.packages = with pkgs; [
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
  
  virtualisation.incus.clientPackage = config.virtualisation.incus.package.client;
}
