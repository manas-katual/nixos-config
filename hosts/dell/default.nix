{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware/broadcom.nix
  ];

  sway.enable = true;
}
