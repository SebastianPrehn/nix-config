;;; init.el --- Sebastian's GNU Emacs config (Nix-managed) -*- lexical-binding: t; -*-

;;; Commentary:
;; Packages are provided by Nix via emacsWithPackagesFromUsePackage.

;;; Code:

;; Produce backtraces when errros occur; helpful to diagnose startup issues
(defun slp/toggle-debug-on-error ()
  "Toggle whether Emacs show backtraces when errors occur."
  (interactive)
  (setq debug-on-error (not debug-on-error))
  (message "Debug on error: %s" debug-on-error))
(global-set-key (kbd "C-c d") #'slp/toggle-debug-on-error)

(setq use-package-always-defer t
      use-package-expand-minimally t)

(setq custom-file (expand-file-name "etc/custom.el" user-emacs-directory))

(use-package no-littering
  :demand t
  :init
  (setq no-littering-etc-directory (expand-file-name "etc/" user-emacs-directory)
	no-littering-var-directory "~/.local/share/emacs/")
  :config
  (setq auto-save-file-name-transforms
	`((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))

(when (file-exists-p custom-file)
  (load custom-file))

(setq-default indent-tabs-mode nil)

(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(set-language-environment "English")

(setq column-number-mode 1)
(setq use-dialog-box nil)
(setq frame-resize-pixelwise t)

(setq default-frame-alist
      (append
      (if (eq system-type 'darwin)
	  '((ns-transparent-titlebar . t) ; Make title bar blend with buffer
	    (ns-appearance . dark)        ; Use dark title bar (or 'light)
	    (alpha-background . 95))      ; Slight transparency (0-100)
	'((undecorated . t)))
      default-frame-alist))

(delete-selection-mode 1)     ; Delete selection when typing
(global-auto-revert-mode t)   ; Auto update buffer when file changes outside of Emacs
(setq vc-follow-symlinks t)   ; Follow symlinks without prompting
(setq-default tab-widt 4)     ; Reasonable default; languages override as needed
(setq yes-or-no-p #'y-or-n-p) ; Use y/n instead of yes/no

(setq backup-directory-alist '(("." . "~/.emacs-backups")))
(setq backup-by-copying t)    ; Don't clobber symlinks
(setq version-control t)      ; Use version numbers on backups
(setq delete-old-versions t)  ; Silently delete old backup versions
(setq kept-new-versions 6)    ; Keep 6 newest versions
(setq kept-old-versions 2)    ; Keep 2 oldest versions

;; Modules setup
(add-to-list 'load-path (expand-file-name "lisp/" user-emacs-directory))
(require 'slp-modules)

;; Declare modules
(slp/modules!
 :ui fonts
 :ui modeline
 :ui theme
 :editor evil
 :completion cape
 :completion consult
 :completion corfu
 :completion embark
 :completion marginalia
 :completion orderless
 :completion tempel
 :completion vertico
 :completion which-key
 :vc magit
 :lang eglot
 :lang nix
 :lang cpp
 :lang futhark
 :lang markdown)


(provide 'init)
;;; init.el ends here
