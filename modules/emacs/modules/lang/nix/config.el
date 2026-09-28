;;; nix/config.el --- Nix language support -*- lexical-binding: t -*-

(defconst slp/nix-config-flake (expand-file-name "~/nix-config")
  "My system flake: sourceo f NixOS/home-manager options, and fallback nixpkgs.")

(defconst slp/nix-host
  (pcase system-type
    ('darwin    '(nix-darwin . "darwinConfigurations.freja"))
    ('gnu/linux '(nixos      . "nixosConfigurations.odin")))
  "(OPTIONS-NAME . FLAKE-ATTR) of this machine's system configuration.")

(defun slp/nixd-configuration (_server)
  "Return nixd settings for the project eglot is starting in.
Package completion uses the nearest Flake's own nixpkgs input, falling
back to the one locked in `slp/nix-config-flake'. Option completion
always comes from odin's configuration."
  (let* ((sys (format "(builtins.getFlake \ \"%s\")" slp/nix-config-flake))
         (root (locate-dominating-file default-directory "flake.nix"))
         (nixpkgs
          (if root
              (format "(builtins.getFlake \"%s\").inputs.nixpkgs or %s.inputs.nixpkgs"
                      (directory-file-name (expand-file-name root)) sys)
            (format "%s.inputs.nixpkgs" sys)))
         (host-opts (and slp/nix-host
                         (format "%s.%s.options" sys (cdr slp/nix-host)))))
    `(:nixd
      (:nixpkgs
       (:expr ,(format "import (%s) { }" nixpkgs))
       ,@(when host-opts
           `(:options
             (,(intern (format ":%s" (car slp/nix-host)))
              (:expr ,host-opts)
              :home-manager
              (:expr ,(format "%s.home-manager.users.type.getSubOptions [ ]"
                              host-opts)))))))))

(use-package nix-mode
  :mode "\\.nix\\'"
  :hook (nix-mode . eglot-ensure))

(use-package nixfmt
  :after nix-mode
  :hook (nix-mode . nixfmt-on-save-mode))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '((nix-mode nix-ts-mode) . ("nixd")))
  (add-to-list 'slp/eglot-workspace-functions #'slp/nixd-configuration))

(provide 'slp-nix)
;;; config.el ends here
