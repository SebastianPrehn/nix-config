;;; eglot/config.el --- Built-in lightweight, standards-compliant Language Server Protocol Client -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package eglot
   :ensure nil
   :hook
   ((c++-ts-mode
    futhark-mode)
    . eglot-ensure))

;;; Prefer tree-sitter modes when available
(setq major-mode-remap-alist
      '((c++-mode . c++-ts-mode)))

(provide 'slp-eglot)
;;; config.el ends here
