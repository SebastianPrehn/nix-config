;;; tempel/config.el --- Template package for Emacs using Emacs' Tempo library -*- lexical-binding: t -*-

;;; Commentary:
;;; Code:

(use-package tempel
  :demand t
  :bind (("M-+" . tempel-complete) ;; Alternative tempel-expand
         ("M-*" . tempel-insert))
  :init
  ;; Setup completion at point
  (defun tempel-setup-capf ()
    ;; Add the Tempel Capf to `completion-at-point-functions'.
    ;; only triggers on exact matches. We add `tempel-expand' before the
    ;; main programming mode Capf, such that it will be tried first.
    (setq-local completion-at-point-functions
                (cons #'tempel-expand completion-at-point-functions)))
  (add-hook 'conf-mode-hook 'tempel-setup-capf)
  (add-hook 'prog-mode-hook 'tempel-setup-capf)
  (add-hook 'text-mode-hook 'tempel-setup-capf)
  :config
  (setq tempel-path (expand-file-name "templates" user-emacs-directory)))

(provide 'slp-tempel)
;;; config.el ends here
