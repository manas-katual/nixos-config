{
  config,
  pkgs,
  inputs,
  userSettings,
  lib,
  ...
}: {
  home-manager.users.${userSettings.username} = {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs; # replace with pkgs.emacs-gtk if desired
    };
    home.packages = with pkgs; [
      gnutls # HTTPS for packages
      imagemagick # image previews in Emacs
      zstd # undo-tree compression
      editorconfig-core-c # optional per-project style
      sqlite # org-roam, etc.
      clang-tools # for C/C++ dev if needed

      cmake
      libtool
      libvterm
      gcc
      gnumake
      pkg-config # for native module building (like vterm)

      emacsPackages.all-the-icons
    ];
  };
}
