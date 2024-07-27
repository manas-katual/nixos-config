{ pkgs, ... }:

{

  home.pointerCursor = {
    gtk.enable = true;
    #x11.enable = true;
    package = pkgs.google-cursor;
    name = "GoogleDot-Black";
    size = 24;
  };
}
