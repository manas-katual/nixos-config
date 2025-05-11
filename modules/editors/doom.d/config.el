(setq user-full-name "Manas Katual"
      user-mail-address "manaskatual@gmail.com")

(setq doom-font (font-spec :family "Intel One Mono" :size 18 :weight 'semi-bold)
      doom-variable-pitch-font (font-spec :family "Intel One Mono" :size 18))

(setq doom-theme 'doom-one)

(setq display-line-numbers-type t)

(setq neo-theme 'icons)

(setq org-directory "~/org/")

(use-package org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode))
