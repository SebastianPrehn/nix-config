;;; haskell/config.el --- Haskell Language support -*- lexical-binding: t -*-

;;; Commentary:

;; Haskell editing with `haskell-mode' and `haskell-language-server' (HLS)
;; through Eglot, plus haskell-mode's own REPL integration.
;;
;; Requirements:
;; - ghc, cabal-install and haskell-lnaguage-server from each project's
;;   devshell (applied per buffer by :tools envrc). HLS must be built
;;   for the same GHC version as the project, so they come from the same
;;   nixpkgs rather than being installed globally.
;; - the :lang eglot module, loaded before this one, for
;;   `slp/eglot-format-on-save' and `slp/eglot-workspace-functions'.
;;
;; Notes:
;; - `haskell-mode-hook' has default entries (indentation and the REPL
;;   minor mode). Adding hooks before the package loads replaces those
;;   defaults, so they are listed explicitly below.
;; - Formatting is done by HLS using ormolu.

;;; Code:

(use-package haskell-mode
  :hook ((haskell-mode . haskell-indentation-mode)
         (haskell-mode . interactive-haskell-mode)
         (haskell-mode . eglot-ensure)
         (haskell-mode . slp/eglot-format-on-save)))

(defun slp/haskell-language-server-configuration (_server)
  "Settings sent to haskell-language-server."
  '(:haskell (:formattingProvider "ormolu")))

(add-to-list 'slp/eglot-workspace-functions
             #'slp/haskell-language-server-configuration)

(slp/when-module kbd general
  (with-eval-after-load 'haskell-mode
    (slp/local-leader-keys
      :keymaps 'haskell-mode-map
      "r" '(haskell-interactive-bring :wk "REPL")
      "l" '(haskell-process-load-file :wk "load file in REPL")
      "b" '(haskell-process-cabal-build :wk "cabal build")
      "h" '(haskell-hoogle-lookup-from-website :wk "hoogle"))))

(provide 'slp-haskell)
;;; config.el ends here
