# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, userSettings, lib, inputs, ... }:

let
  terminal = pkgs.${userSettings.terminal};
in
{
  imports =
    ( 
      import ../modules/desktops ++
      import ../modules/programs ++
      import ../modules/theming ++
      import ../modules/services ++
      import ../modules/shell ++
      import ../modules/editors
    );

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dell"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  #services.xserver.xkb = {
  #  layout = "in";
  #  variant = "eng";
  #};

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    #sudo.wheelNeedsPassword = false;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = "Manas Katual";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "libvirtd" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
    environment = {
    variables = {
      TERMINAL = "${userSettings.terminal}";
      EDITOR = "${userSettings.editor}";
      VISUAL = "${userSettings.editor}";
    };
    systemPackages = with pkgs; [

	# terminal tools
	neovim 
	wget
	terminal
	htop
	fastfetch
	tldr # helper
	usbutils # manage usb
	pciutils # manage pci
	xdg-utils # environment integration
	coreutils # GNU utils
	gvfs
	nix-tree # browse nix store
	android-tools # fastboot and adb tool

	# apps
	google-chrome # browser
	image-roll # image viewer
	mpv # video player
	qbittorrent # torrent client
	appimage-run # for appimages
	anydesk # remote access
	lan-mouse # kbd & mouse share
	localsend # wireless file transfer
	bottles # to run windows apps
	vscode-fhs # vscode for noobs
	nodejs # backend for js
	netbeans # ide
	jdk23 # compiler
	mission-center # task manager for linux
	komikku # manga reader
    ];
  };

  fonts.packages = with pkgs; [
    carlito # NixOS
    vegur # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome # Icons
    corefonts # MS
    noto-fonts # Google + Unicode
    noto-fonts-cjk-sans
    noto-fonts-emoji
    powerline-fonts
    powerline-symbols
    twemoji-color-font
    intel-one-mono
    fira-code
    #nerd-fonts.NerdFontsSymbolOnly
    #(nerdfonts.override {
    #  fonts = [
    #    "FiraCode"
	#"NerdFontsSymbolsOnly"
    #  ];
    #})
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  programs = {
    dconf.enable = true;
  };

  services = {
    devmon.enable = true;
    gvfs.enable = true;
    dbus.enable = true;
  };

  hardware.pulseaudio.enable = false;
  services = {
    printing = {
      enable = true;
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    openssh = {
      enable = true;
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      extra-substituters = [ "https://nix-community.cachix.org" ];
      extra-trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
      #substituters = [ "https://hyprland.cachix.org" ];
      #trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    # package = pkgs.nixVersions.latest;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  home-manager.users.${userSettings.username} = {
    home = {
      stateVersion = "24.05";
    };
    programs = {
      home-manager.enable = true;
    };
  };



}
