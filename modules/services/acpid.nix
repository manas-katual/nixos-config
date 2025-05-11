{config, lib, pkgs, ... }:
{
  services.acpid.enable = true;
  environment.systemPackages = [
    pkgs.acpi
  ];
}
