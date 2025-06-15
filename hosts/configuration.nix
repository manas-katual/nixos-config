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
{
  config,
  pkgs,
  userSettings,
  lib,
  inputs,
  ...
}: let
  terminal = pkgs.${userSettings.terminal};
in {
  imports = (
    import ../modules/desktops
    ++ import ../modules/programs
    ++ import ../modules/theming
    ++ import ../modules/services
    ++ import ../modules/shell
    ++ import ../modules/editors
    ++ import ../modules/custom
    ++ import ../modules/hardware
    ++ import ../modules/scripts
  );

  nix.package = pkgs.lix;

  boot = {
    tmp = {
      cleanOnBoot = true;
      tmpfsSize = "5GB";
    };
    # kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "nokia"; # Define your hostname.
    networkmanager.enable = true; # network manager systemd
    #wireless.enable = true; # Enables wireless support via wpa_supplicant.
  };
  time.timeZone = "Asia/Kolkata";
  time.hardwareClockInLocalTime = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
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

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = "Manas Katual";
    extraGroups = ["networkmanager" "wheel" "video" "audio" "libvirtd" "input"];
    packages = with pkgs; [];
  };

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
      # coreutils # GNU utils
      procps # GNU utils with addition
      gvfs # samba
      nix-tree # browse nix store
      pulseaudio # audio controller

      # gui apps
      # google-chrome # browser
      firefox # browser
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
      onlyoffice-desktopeditors # office suite
      neovide # neovim gui
      hardinfo2 # shows hardware info
      # ciscoPacketTracer8 # networking emulation
      soundwireserver # to listen audio from pc to mobile
      vesktop # discord client

      # games and emulation
      mcpelauncher-ui-qt # minecraft bedrock edition
      ppsspp-sdl-wayland # psp emulator
      dolphin-emu-primehack # gamecube and wii emulator
    ];
  };

  networking.firewall.allowedTCPPorts = [59010]; # for soundwire
  networking.firewall.allowedUDPPorts = [59010]; # for soundwire

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
    dejavu_fonts
  ];

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  programs = {
    dconf.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  services = {
    printing = {
      enable = true;
    };
    pulseaudio = {
      enable = false;
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
    devmon.enable = true;
    dbus.enable = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      substituters = [
        "https://cache.nixos.org?priority=10"

        "https://hyprland.cachix.org"
        "https://anyrun.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
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

  nixpkgs.config.allowUnfree = true;

  # =============== #
  # DONT TOUCH THIS #
  # =============== #
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
