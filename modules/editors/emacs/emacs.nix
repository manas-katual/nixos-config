{ pkgs, config, userSettings, ... }:

{
  home-manager.users.${userSettings.username} = {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-gtk;
      extraPackages = epkgs: with epkgs; [
        use-package
        evil
        evil-collection
        evil-tutor
        general
        all-the-icons
        all-the-icons-dired
        counsel
        ivy
        all-the-icons-ivy-rich
        ivy-rich
        toc-org
        org-bullets
        which-key
        eshell-syntax-highlighting
        eshell-toggle
        vterm
        vterm-toggle
        sudo-edit
        rainbow-mode
        rainbow-delimiters
        dashboard
        projectile
        nix-mode
        lua-mode
        haskell-mode
        flycheck
        diminish
        company
        company-box
        doom-themes
        doom-modeline
        dired-open
        peep-dired 
        neotree
        git-timemachine
        magit
        hl-todo
        perspective
        tldr
      ];
    };

    services.emacs = {
      enable = true;
      client.enable = true;
    };

    home.file.".config/emacs" = {
      source = ./emacs;
      recursive = true;
    };
  };

}
