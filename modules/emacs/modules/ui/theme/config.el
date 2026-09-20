;;; theme/config.el --- Theme for Emacs -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq custom-safe-themes t)
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))

(use-package kaolin-themes
  :demand t
  :custom
  (kaolin-themes-italic-comments t)
  (kaolin-themes-hl-line-colored t)
  (kaolin-themes-distinct-fringe t)
  (kaolin-themes-git-gutter-solid t)
  :config
  (load-theme 'kaolin-dark t))

(provide 'slp-theme)
;;; config.el ends here
