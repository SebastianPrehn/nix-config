;;; eldoc-box/config.el --- Documentation in a popup -*- lexical-binding: t -*-

;;; Commentary:

;; Shows eldoc documentation ()eglot hover, Elisp signatures) in a child
;; frame. `K' in normal state opens it for the thing at point; C-g or
;; moving closes it. The echo area keeps its short one-line hint.

;;; Code:

(use-package eldoc-box
  :commands (eldoc-box-help-at-point)
  :hook ((eglot-managed-mode emacs-lisp-mode) . eldoc-box-hover-at-point-mode)
  :custom
  (eldoc-box-clear-with-C-g t))

(provide 'slp-eldoc-box)
;;; config.el ends here
