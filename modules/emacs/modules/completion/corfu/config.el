;;; corfu/config.el --- Lightweight popup interface for in-buffer completion -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package corfu
  :demand t
  :after orderless
  :custom
  (corfu-cycle t) ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t) ;; Enable auto completion
  (corfu-separator ?\s)
  (corfu-quit-at-boundary nil)
  (corfu-quit-no-match nil)
  :config
  (global-corfu-mode))

(use-package emacs
  :ensure nil
  :custom
  ;; TAB cycle if there are only few candidates
  (completion-cycle-threshold 4)
  ;; Enable indentation+completion using the TAB key
  (tab-always-indent 'complete)
  ;; Disable Ispell completion function to try cape-dict instead as an alternative
  (text-mode-ispell-word-completion nil)
  ;; Hide commands in M-x which do not apply to the current mode. This is not a corfu feature, but rather just a tip from Minad
  (read-extended-command-predicate #'command-completion-default-include-p))

(provide 'slp-corfu)
;;; config.el ends here
