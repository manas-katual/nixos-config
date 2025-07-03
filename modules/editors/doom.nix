{
  config,
  pkgs,
  inputs,
  userSettings,
  lib,
  ...
}: let
  homeDir = "/home/${userSettings.username}";
in {
  services.emacs = {
    enable = true;
  };
  home-manager.users.${userSettings.username} = {
    services.emacs = {
      enable = true;
      client.enable = true;
      startWithUserSession = "graphical";
    };

    programs.emacs = {
      enable = true;
      package = pkgs.emacs.pkgs.withPackages (epkgs:
        with epkgs; [
          treesit-grammars.with-all-grammars
          vterm
        ]);
    };

    home.packages = with pkgs; [
      binutils
      (ripgrep.override {withPCRE2 = true;})
      gnutls
      fd
      imagemagick
      zstd
      emacs-all-the-icons-fonts
    ];

    home = {
      sessionVariables = {
        DOOMDIR = "${homeDir}/.config/doom";
        EMACSDIR = "${homeDir}/.config/emacs";
        DOOMLOCALDIR = "${homeDir}/.local/share/doom";
        DOOMPROFILELOADFILE = "${homeDir}/.local/state/doom-profiles-load.el";
      };

      # Note! This must correspond to $EMACSDIR
      sessionPath = ["${homeDir}/.config/emacs/bin"];
    };

    home.file."${homeDir}/.config/emacs".source = inputs.doom-emacs;

    xdg.configFile."doom" = {
      source = ./doom;
      recursive = true;
    };
  };
}
