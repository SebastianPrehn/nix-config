;;; early-init.el --- Emacs 27+ pre-initialization config -*- lexical-binding: t -*-

;;; Commentary:

;; Emacs 27+ loads this file before calling
;; `package-initialize'. We use this file to supress that automatic
;; behavior so that startup is consistent across Emacs versions.

;;; Code:

(setq package-enable-at-startup nil)


(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize 'force
      frame-title-format '("%b")
      ring-bell-function 'ignore
      use-file-dialog nil
      use-short-answers t
      inhibit-splash-screen t
      inhibit-startup-screen t
      inhibit-x-resources t
      inhibit-startup-buffer-menu t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; So we can detect this having been loaded
(provide 'early-init)

;;; early-init.el ends here
