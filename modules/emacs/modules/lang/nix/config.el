;;; nix/config.el --- Nix language support -*- lexical-binding: t -*-

(defconst slp/nix-config-flake "/home/sebastian/nix-config"
  "My system flake: sourceo f NixOS/home-manager options, and fallback nixpkgs.")

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
            (format "%s.inputs.nixpkgs" sys))))
    `(:nixd
      (:nixpkgs
       (:expr ,(format "import (%s) { }" nixpkgs))
       :options
       (:nixos
        (:expr ,(format "%s.nixosConfigurations.odin.options" sys))
        :home-manager
        (:expr ,(format "%s.nixosConfigurations.odin.options.home-manager.users.type.getSubOptions [ ]" sys)))))))

(use-package nix-mode
  :mode "\\.nix\\'"
  :hook (nix-mode . eglot-ensure))

(use-package nixfmt
  :after nix-mode
  :hook (nix-mode . nixfmt-on-save-mode))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '((nix-mode nix-ts-mode) . ("nixd")))
  (setq-default eglot-workspace-configuration #'slp/nixd-configuration))

(provide 'slp-nix)
;;; config.el ends here
