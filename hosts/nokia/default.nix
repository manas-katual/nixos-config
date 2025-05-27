#
#  Specific system configuration settings for dell inspiron 15 3521
#
#  flake.nix
#   ├─ ./hosts
#   │   ├─ default.nix
#   │   └─ ./dell
#   │        ├─ default.nix *
#   │        └─ hardware-configuration.nix
#   └─ ./modules
#       └─ ./desktops
#           └─ hyprland.nix
#
{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ (import ../../modules/hardware/nokia);

  # Boot Options
  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
      };
      efi = {
        canTouchEfiVariables = true;
      };
      timeout = 5;
    };
  };

  hyprland.enable = true;
  # sway.enable = true;
  # qtile.enable = true;
  # gnome.enable = true;
  laptop.enable = true;

  environment = {
    systemPackages = with pkgs; [
      pipe-viewer # youtube in terminal
      manga-tui # manga reader
    ];
  };

  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 50;
    priority = 999;
  };
  boot.kernel.sysctl = {
    "vm.page-cluster" = 0;
    "vm.swappiness" = 20;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_ratio" = 10;
    "vm.dirty_background_ratio" = 5;
    "kernel.sysrq" = 1;
  };
  services = {
    # for SSD/NVME
    fstrim.enable = true;
    scx.enable = true;
    scx.scheduler = "scx_rusty";
  };

  networking.networkmanager.wifi.powersave = false;
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
}
