;;; which-key/config.el --- Display key bindings based on already entered incomplete commands -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package which-key
  :demand t
  :config
  (which-key-mode 1)
  (setq which-key-idle-delay 0.3)
  (setq which-key-popup-type 'side-window)
  (setq which-key-side-window-location 'bottom)
  (setq which-key-side-window-max-height 0.25) ; 25% of frame height
  (setq which-key-max-description-length 40)
  (setq which-key-add-column-padding 1)
  (setq which-key-separator " → "))

(provide 'slp-which-key)
;;; config.el ends here
