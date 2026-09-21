;;; embark/config.el --- Keyboard-based version of a right-click contextual menu -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package embark
  :bind (("C-." . embark-act)
         :map minibuffer-local-map
         ("C-c C-c" . embark-collect)
         ("C-c C-e" . embark-export)))

(use-package embark-consult
  :after embark consult)

(provide 'slp-embark)
