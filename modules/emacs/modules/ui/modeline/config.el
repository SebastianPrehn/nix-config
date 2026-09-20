;;; modeline/config.el --- Modeline setup -*- lexical-binding: t -*-

(use-package doom-modeline
  :demand t
  :custom
  (doom-modeline-project-detection 'auto)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-major-mode-color-icon t)
  (doom-modeline-buffer-modification-icon t)
  (doom-modeline-lsp-icon t)
  (doom-modeline-time-icon t)
  :config
  (doom-modeline-mode 1))

(provide 'slp-modeline)
;;; config.el ends here
