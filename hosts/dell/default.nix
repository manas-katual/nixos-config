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

{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ] ++ 
  (import ../../modules/hardware/dell);

  # Boot Options
  boot = {
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
  laptop.enable = true;

  environment = {
    systemPackages = with pkgs; [
      nchat # whatsapp & telegram tui-client
      ripcord # dicord client
      spotify-player # spotify in terminal
      pipe-viewer # youtube in terminal
    ];
  };

  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 100;
    priority = 999;
  };
	boot.kernel.sysctl."vm.page-cluster" = 0;

}
