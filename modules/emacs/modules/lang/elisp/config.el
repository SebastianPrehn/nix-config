;;; elisp/config.el --- Emacs Lisp development -*- lexical-binding: t -*-

;;; Commentary:

;; Emacs Lisp support is mostly built-in.
;; This module adds live diagnostics, inline macro expansion,
;; and eval/debug commands on the local leader.

;;; Code:

(use-package elisp-mode
  :ensure nil
  :hook (emacs-lisp-mode . flymake-mode)
  :config
  ;; Let the byte-compile checker see Nix-provided packages, so it doesn't
  ;; flag every function from them as unknown.
  (setq elisp-flymake-byte-compile-load-path load-path)
  (add-to-list 'trusted-content "~/nix-config/"))

;; Expand macros inline, step by step (e.g. to see what a `use-package'
;; form turns into)
(use-package macrostep
  :commands (macrostep-expand))

(slp/when-module kbd general
  (slp/local-leader-keys
    :keymaps '(emacs-lisp-mode-map lisp-interaction-mode-map)
    "e" '(:ignore t :wk "eval")
    "ee" '(eval-last-sexp :wk "last sexp")
    "ed" '(eval-defun :wk "defun")
    "eb" '(eval-buffer :wk "buffer")
    "er" '(eval-region :wk "region")
    "m" '(macrostep-expand :wk "expand macro")
    "d" '(edebug-defun :wk "debug defun")
    "r" '(ielm :wk "REPL")))

(provide 'slp-elisp)
;;; config.el ends here
