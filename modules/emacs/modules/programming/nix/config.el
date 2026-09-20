;;; nix/config.el --- Nix language support -*- lexical-binding: t -*-

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package nixfmt
  :after nix-mode
  :hook (nix-mode . nixfmt-on-save-mode))

(provide 'slp-nix)
;;; config.el ends here
