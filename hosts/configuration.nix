#
#  Main system configuration. More information available in configuration.nix(5) man page.
#
#  flake.nix
#   ├─ ./hosts
#   │   ├─ default.nix
#   │   └─ configuration.nix *
#   └─ ./modules
#       ├─ ./desktops
#       │   └─ default.nix
#       ├─ ./editors
#       │   └─ default.nix
#       ├─ ./hardware
#       │   └─ default.nix
#       ├─ ./programs
#       │   └─ default.nix
#       ├─ ./services
#       │   └─ default.nix
#       ├─ ./shell
#       │   └─ default.nix
#       └─ ./theming
#           └─ default.nix
#

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
      import ../modules/editors ++
      import ../modules/hardware
    );

  networking = {
    hostName = "dell"; # Define your hostname.

    # enable networking
    networkmanager.enable = true; # network manager systemd
    #wireless.enable = true; # Enables wireless support via wpa_supplicant.
  }; 

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_IN";
    extraLocaleSettings = {
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
      neovim # text editor 
      wget # downloader
      terminal
      htop # cpu usage
      fastfetch # system info
      tldr # helper
      usbutils # manage usb
      pciutils # manage pci
      xdg-utils # environment integration
      coreutils # GNU utils
      gvfs # samba
      nix-tree # browse nix store
      android-tools # fastboot and adb tool

      # gui apps
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
      mission-center # task manager for linux
      komikku # manga reader
      zathura # pdf reader
      hplip # hp printing drivers
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
    fira-mono
    fira-sans
    nerd-fonts.dejavu-sans-mono
    #nerd-fonts.NerdFontsSymbolOnly
    #(nerdfonts.override {
    #  fonts = [
    #    "FiraCode"
    #"NerdFontsSymbolsOnly"
    #  ];
    #})
  ];

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
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # DONT TOUCH THIS
  system.stateVersion = "24.05"; 

  home-manager.users.${userSettings.username} = {
    home = {
      stateVersion = "24.05";
    };
    programs = {
      home-manager.enable = true;
    };
  };



}
