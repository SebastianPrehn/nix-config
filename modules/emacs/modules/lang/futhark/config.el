;;; futhark/config.el --- Futhark language config -*- lexical-binding: t -*-

;;; Commentary:
;; A data-parallel functional programming language developed at DIKU
;; https://github.com/diku-dk/futhark

;;; Code:

(use-package futhark-mode
  :mode "\\.fut\\'")

(use-package futhark-fmt
  :ensure nil ;; bundled inside the futhark-mode package
  :after futhark-mode
  :hook (futhark-mode . futhark-fmt-on-save-mode))

(provide 'slp-futhark)
;;; config.el ends here
