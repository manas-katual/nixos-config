{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with pkgs; [
    # Doom Emacs build dependencies
    cmake
    libtool
    libvterm
    gcc
    gnumake
    pkg-config

    # Optional runtime tools
    gnutls # TLS for Emacs packages
    imagemagick # image previews
    zstd # undo-tree compression
    editorconfig-core-c # .editorconfig support
    sqlite # for org-roam/db features
    clang-tools # for C/C++ LSPs

    # Tools doom doctor warned about
    nodejs # includes npm
    nixfmt-classic # Nix formatter
    shellcheck # shell script linting
    # markdown # markdown-preview

    # Fonts (just for info; you probably installed manually/system-wide)
    # (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) # optional

    # Optional if you want to add Emacs itself here
    # emacs
  ];

  shellHook = ''
    echo "🔧 Doom Emacs Dev Shell loaded with all required tools!"
  '';
}
