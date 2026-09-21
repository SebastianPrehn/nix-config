;;; speedbar/config.el --- Built-in file explorer -*- lexical-binding: t -*-
;;; Commentary:

;; Without `speedbar-prefer-window' the `speedbar' shows up in
;; a seperate frame.

;; `speedbar-use-images' determines whether speedbar provides
;; `cdr' of each `speedbar-expand-image-button-alist'.

;;; Code:

(use-package speedbar
  :ensure nil
  :commands (speedbar)
  :config
  (setq speedbar-prefer-window t)
  (setq speedbar-use-images t))

(provide 'slp-speedbar)
;;; config.el ends here
