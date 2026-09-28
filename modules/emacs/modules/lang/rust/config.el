;;; rust/config.el --- Rust setup via rust-ts-mode and rust-analyzer -*- lexical-binding: t -*-

;;; Commentary:

;; Rust editing with the built-in `rust-ts-mode' and rust-analyzer
;; through Eglot.
;;
;; Requirements:
;;
;; - Tree-sitter grammars for Rust and TOML, provided by the Emacs
;;   package in modules/emacs/default.nix (`treesit-grammars').
;; - rust-analyzer, cargo, rustc, rustfmt, and clippy on PATH. These
;;   come from each project's devshell, which the :tools envrc module
;;   applies per buffer; nothing is installed globally.
;; - The :lang eglot module, loaded before this one, for
;;   `slp/eglot-format-on-save' and `slp/eglot-workspace-functions'.
;;
;; Behavior:
;;
;; - .rs files open in `rust-ts-mode' and start rust-analyzer.
;; - Buffers are formatted with rustfmt (through rust-analyzer) on save.
;; - rust-analyzer runs clippy instead of `cargo check' for
;;   diagnostics; see `slp/rust-analyzer-configuration'.
;;
;; Notes:
;;
;; Project roots come from git, not Cargo.toml, so a Cargo workspace
;; gets a single rust-analyzer instead of one per member crate.

;;; Code:

(use-package rust-ts-mode
  :ensure nil ; built-in
  :mode "\\.rs\\'"
  :hook ((rust-ts-mode . eglot-ensure)
         (rust-ts-mode . slp/eglot-format-on-save)))

(use-package toml-ts-mode
  :ensure nil ; built-in
  :mode "\\.toml\\'")

(defun slp/rust-analyzer-configuration (_server)
  "Settings sent to rust-analyzer."
  '(:rust-analyzer (:check (:command "clippy"))))

(add-to-list 'slp/eglot-workspace-functions #'slp/rust-analyzer-configuration)

(provide 'slp-rust)
;;; config.el ends here
