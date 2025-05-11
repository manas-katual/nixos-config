{ pkgs, ...}:
{
  virtualisation.waydroid.enable = true;

  environment.systemPackages = with pkgs; [
    nur.repos.ataraxiasjel.waydroid-script
  ];

  # run this commands after installing waydroid for some extra stuffs
  
  # sudo waydroid init -s GAPPS -f
  # find /nix/store -type f -iname waydroid-script
  # cd into the waydroid-script-0/bin
  # sudo waydroid-script
}
