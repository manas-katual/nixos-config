#
#  GTK
#

{ lib, config, pkgs, host, userSettings, ... }:

{
  home-manager.users.${userSettings.username} = {
    home = {
      pointerCursor = {
        gtk.enable = true;
        name = lib.mkForce "Dracula-cursors";
        package = lib.mkForce pkgs.dracula-theme;
        size = lib.mkForce 16;
        x11 = {
          enable = true;
          defaultCursor = "Dracula-cursors";
        };
      };
    };

    gtk = #lib.mkIf (config.gnome.enable == false) 
    {
      enable = true;
      #theme = {
        #name = "Dracula";
        #name = "Catppuccin-Mocha-Compact-Blue-Dark";
        #name = "Orchis-Dark-Compact";
        #package = pkgs.dracula-theme;
        # package = pkgs.catppuccin-gtk.override {
        #   accents = ["blue"];
        #   size = "compact";
        #   variant = "mocha";
        # };
        #package = pkgs.orchis-theme;
      #};
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      #font = {
      #  name = "FiraCode Nerd Font Mono Medium";
      #};
    };

     qt = {
       enable = true;
    #   platformTheme.name = "gtk";
    #   style = {
    #     name = "adwaita-dark";
    #     package = pkgs.adwaita-qt;
    #   };
     };
  };

  # environment.variables = {
  #   QT_QPA_PLATFORMTHEME = "gtk2";
  # };
}
