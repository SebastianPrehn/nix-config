;;; markdown/config.el --- Lightweight markup language -*- lexical-binding: t -*-

;;; Commentary:
;;; Code:

(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :init
  (setq markdown-command "pandoc")
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do))
  :config
  (setq markdown-fontify-code-blocks-natively t))

(provide 'slp-markdown)
;;; config.el ends here
