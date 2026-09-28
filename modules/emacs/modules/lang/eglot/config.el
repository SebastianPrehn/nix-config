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

;;; Per-server settings

(defvar slp/eglot-workspace-functions nil
  "Functions of one argument (the Eglot server) returning a plist of settings.
Their results are merged into `eglot-workspace-configuration'.")

(defun slp/eglot-workspace-configuration (server)
  "Merge the settings from every function in `slp/eglot-workspace-functions'."
  (apply #'append
         (mapcar (lambda (fn) (funcall fn server)) slp/eglot-workspace-functions)))

(setq-default eglot-workspace-configurations #'slp/eglot-workspace-confiuguration)

;;; Format on save, opt-in per language

(defun slp/eglot-format-if-managed ()
  "Format the buffer through the language server when Eglot manages it."
  (when (and (fboundp 'eglot-managed-p) (eglot-managed-p))
    (eglot-format-buffer)))

(defun slp/eglot-format-on-save ()
  "Format the current buffer through its language server before saving."
  (add-hook 'before-save-hook #'slp/eglot-format-if-managed nil t))

;;; Workspace symbol search through consult

(use-package consult-eglot
  :after (consult eglot))

;;; Keybindings under the `SPC c' code prefix

(slp/when-module kbd general
  (slp/leader-keys
    "ca" '(eglot-code-actions :wk "code actions")
    "cr" '(eglot-rename :wk "rename")
    "cf" '(eglot-format-buffer :wk "format buffer")
    "cd" '(flymake-show-buffer-diagnostics :wk "buffer diagnostics")
    "cD" '(flymake-show-project-diagnostics :wk "project diagnostics")
    "cs" '(consult-eglot-symbols :wk "workspace symbols")))

(provide 'slp-eglot)
;;; config.el ends here
