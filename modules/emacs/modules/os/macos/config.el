;;; macos/config.el --- MacOS-specific settings -*- lexical-binding: t -*-

;;; Commentary:

;; MacOS has a different keyboard layout, with its `control', `option' and
;; `command' keys, and these require different keypresses than I'm used to.

;;; Code:

(setq mac-command-modifier 'meta
      mac-option-modifier nil
      mac-control-modifier 'control
      mac-right-command-modifier 'super
      mac-right-control-modifier 'hyper)


; GUI Emacs on macOS doesn't inherit the shell's PATH, so add the Nix
;; profile directories nix-darwin/home-manager install into.
(let ((dirs (seq-filter
             #'file-directory-p
             (list (format "/etc/profiles/per-user/%s/bin" user-login-name)
                   (expand-file-name "~/.nix-profile/bin")
                   "/run/current-system/sw/bin"
                   "/nix/var/nix/profiles/default/bin"))))
  (setq exec-path (append dirs exec-path))
  (setenv "PATH" (string-join (append dirs (list (getenv "PATH")))
                              path-separator)))
;; I wish I could just use exec-path-from-shell by Purcell, but I can't get it
;; to work

(provide 'slp-macos)
;;; config.el ends here
