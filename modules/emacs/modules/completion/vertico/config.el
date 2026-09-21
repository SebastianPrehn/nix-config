;;; vertico/config.el --- Minimal, vertical completion UI for minibuffer -*- lexical-binding: t -*-

;;; Commentary:

;; The vertico package provides a minimal, vertical completion UI for the minibuffer. Rather than replacing Emacs’ completion system, it focuses solely on presenting candidates in a clear, efficient layout.

;; vertico is intentionally small and performs well out of the box, while still allowing fine-grained control of its behavior. Here, cycling is enabled to allow wrapping around the candidate list, while automatic resizing is disabled to keep the minibuffer height stable.

;;; Code:
(use-package vertico
  :demand t
  :config
  (setq vertico-cycle t)
  (setq vertico-resize nil)
  (vertico-mode 1))

;; Vertico can use information from `savehist-mode' and `recentf-mode' to put
;; recently selected options at the top by enabling these built-in options.

;;; `savehist' (minibuffer and related histories)
(setq savehist-file (locate-user-emacs-file "savehist"))
(setq history-length 100)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history t)
(with-eval-after-load 'savehist
  (add-to-list 'savehist-additional-variables 'kill-ring))
(savehist-mode 1)
(recentf-mode 1)

(provide 'slp-vertico)
;;; config.el ends here
