;;; magit/config.el --- Text-based user interface for Git -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package transient)

(use-package magit
  :bind (("M-g b" . magit-blame-addition)
         :map magit-mode-map
         ("C-M-f" . magit-section-forward)
         ("C-M-b" . magit-section-backward))
  :config
  (setq magit-mode-quit-window 'magit-restore-window-configuration
        magit-auto-revert-mode t))

(use-package forge
  :after magit)

(use-package blamer
  :after magit
  :bind (("C-c g i" . blamer-show-commit-info)
         ("C-c g b" . blamer-show-posframe-commit-info))
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 4)
  (blamer-max-commit-message-length 100)
  (blamer-datetime-formatter "[%s]")
  (blamer-commit-formatter " ● %s")
  :custom-face
  (blamer-face ((t :foreground "#7aa2cf"
                   :background nil
                   :height 1
                   :italic nil))))

(use-package git-link
  :commands (git-link git-link-commit)
  :custom
  (git-link-use-commit t)
  (git-link-open-in-browser t))

(use-package git-timemachine)

(provide 'slp-magit)
;;; config.el ends here
