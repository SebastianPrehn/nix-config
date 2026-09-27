;;; fonts/config.el --- Fonts -*- lexical-binding: t -*-

(defvar slp/font-family "Comic Mono")
(defvar slp/font-height (if (eq system-type 'darwin) 160 140)
  "Default font height.")

;; default-frame-alist covers frames created by emacsclient
(add-to-list 'default-frame-alist
             `(font . ,(format "%s-%d" slp/font-family (/ slp/font-height 10))))
(set-face-attribute 'default nil :family slp/font-family :height slp/font-height)
(set-face-attribute 'fixed-pitch nil :family slp/font-family :height 1.0)

(use-package nerd-icons)

(use-package nerd-icons-dired
	     :hook (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-ibuffer
	     :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(provide 'slp-fonts)
;;; config.el ends here
