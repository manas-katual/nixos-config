{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lutris
    heroic
    bottles
  ];
}
