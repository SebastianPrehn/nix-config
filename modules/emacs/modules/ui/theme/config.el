;;; theme/config.el --- Theme for Emacs -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq custom-safe-themes t)
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))

(use-package doom-themes
  :demand t
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config
  (load-theme 'doom-wilmersdorf t))

(use-package solaire-mode
  :after doom-themes
  :config
  (solaire-global-mode +1))

(provide 'slp-theme)
;;; config.el ends here
