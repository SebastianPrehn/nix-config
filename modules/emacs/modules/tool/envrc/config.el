;;; envrc/config.el --- Per-buffer direnv environments -*- lexical-binding: t -*-

;;; Commentary:

;; Applies a project's direnv environment (usually its Nix devshell) to
;; every buffer visiting files in that project. Processes started from
;; those buffers -- Eglot's language servers, `compile', magit, shells --
;; see the project's PATH and variables, so e.g. rust-analyzer and cargo
;; come from the project's flake rather than being installed globally.
;;
;; Requirements:
;;
;; - direnv on PATH, plus nix-direnv for cached `use flake'; both come
;;   from `programs.direnv' in home/common.nix.
;; - The project has an allowed .envrc (`direnv allow', or
;;   `envrc-allow' below).
;;
;; Notes:
;;
;; - Load this module last in `slp/modules!': envrc's hook should run
;;   before other modes' hooks, so buffers get their environment before
;;   e.g. `eglot-ensure' starts a server.
;; - After changing a project's flake.nix, run `envrc-reload' and then
;;   `eglot-reconnect' so the server restarts with the same environment.

;;; Code:

(use-package envrc
  :demand t
  :hook (after-init . envrc-global-mode))

(slp/when-module kbd general
  (slp/leader-keys
    "ea" '(envrc-allow :wk "allow .envrc")
    "er" '(envrc-reload :wk "reload environment")
    "eR" '(envrc-reload-all :wk "reload all buffers")
    "ed" '(envrc-deny :wk "deny .envrc")))

(provide 'slp-envrc)
;;; config.el ends here
