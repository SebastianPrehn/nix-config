;;; elfeed/config.el --- RSS/atom feed manager -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package elfeed
  :demand t
  :custom
  (elfeed-db-directory (expand-file-name "elfeed" user-emacs-directory))
  (elfeed-use-curl t)
  (elfeed-curl-max-connections 8)
  (elfeed-curl-extra-arguments '("--silent" "--max-time" "20"))
  (elfeed-show-entry-switch 'display-buffer))

(use-package elfeed-org
  :demand t
  :config
  (setq rmh-elfeed-org-files
        (list (expand-file-name "elfeed.org" user-emacs-directory)))
  (elfeed-org))


(provide 'slp-elfeed)
;;; config.el ends here
