{ config, pkgs, userSettings, ... }:
{
  
  environment.systemPackages = with pkgs; [
    google-chrome
  ];
  programs = {
    chromium = {
      enable = true;
      extensions = [
        # https://chromewebstore.google.com/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm
        "ddkjiahejlhfcafbddmgiahcphecmpfh" # ublock origin lite
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
        "jiaopdjbehhjgokpphdfgmapkobbnmjp" # youtube-shorts block
      ];
    };
  };
}

