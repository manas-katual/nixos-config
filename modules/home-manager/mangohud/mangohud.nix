{ pkgs, ... }:
{

  programs.mangohud = {
    enable = true;
    package = pkgs.mangohud;
    enableSessionWide = true;
    settings = {
      output_folder = ./mangohud.conf;
      full = true;
    };
  };
}
