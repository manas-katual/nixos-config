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
    wget
		firefox

    python3
    python312Packages.pip
    python312Packages.pyaudio
    espeak
    pylint
    
    pavucontrol
    tree
    vscodium-fhs
    cpu-x
    vesktop
    tgpt
    neovide
    spice
    spice-protocol
    spice-gtk
    blueberry
    mediawriter
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    radeontop
    glxinfo
    eza
    mpv
    eww
    libnotify
		#fragments
		libsForQt5.ark
		disfetch

    olive-editor
		#libsForQt5.kdenlive
    kdePackages.kdenlive
		glaxnimate
		obs-studio

		bat
		eog
		scrcpy
		acpi
		lan-mouse
		#swaynotificationcenter
		
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
   ++ (if (config.programs.hyprland.enable == true)
          then [pkgs.rofi-wayland]
         else 
           (if (config.programs.wayfire.enable == true) || (config.programs.sway.enable == true)
             then [pkgs.rofi-wayland pkgs.swayidle pkgs.swaylock pkgs.swaybg]
         else 
           (if (config.services.xserver.windowManager.dwm.enable == true)
             then [pkgs.rofi]
       else [])));

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
