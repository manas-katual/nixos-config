{ pkgs, config, inputs, lib, system, ... }:

{
  

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  #boot.loader.grub.useOSProber = true;

  #boot.loader.grub.splashImage = ./linux.png;
  #boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
  #pname = "distro-grub-themes";
  #version = "3.1";
  #src = pkgs.fetchFromGitHub {
  #  owner = "AdisonCavani";
  #  repo = "distro-grub-themes";
  #  rev = "v3.1";
  #  hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
  #};
  #installPhase = "cp -r customize/dell $out";
#};

  boot.loader.grub = {
    theme = inputs.nixos-grub-themes.packages.${pkgs.system}.nixos;
  };



}
