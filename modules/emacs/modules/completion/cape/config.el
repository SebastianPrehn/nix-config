;;; cape/config.el --- Completion At Point Extensions -*- lexical-binding: t -*-

;;; Commentary:

;; Used in combination with Corfu, and can utilize Company as well.

;;; Code:

(use-package cape
  :demand t
  :bind ("C-c p" . cape-prefix-map)
  :init
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-dict)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (setq-local completion-at-point-functions
                          (list (cape-capf-super
                                 #'eglot-completion-at-point
                                 #'cape-dabbrev))))))

(provide 'slp-cape)
;;; config.el ends here
