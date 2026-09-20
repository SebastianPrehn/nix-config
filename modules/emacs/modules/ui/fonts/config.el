;;; fonts/config.el --- Fonts -*- lexical-binding: t -*-

(use-package nerd-icons)

(use-package nerd-icons-dired
	     :hook (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-ibuffer
	     :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(provide 'slp-fonts)
;;; config.el ends here
