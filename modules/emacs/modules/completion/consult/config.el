;;; consult/config.el --- Enhanced variants of many built-in Emacs commands -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package consult
  :bind (;; A recursive grep
         ("M-s M-g" . consult-grep)
         ;; Search for file names recursively
         ("M-s M-f" . consult-find)
         ;; Search through the outline (headings) of the file
         ("M-s M-o" . consult-outline)
         ;; Search through the imenu entries
         ("M-g i" . consult-imenu)
         ;; Search the current buffer. Overrides I-search.
         ("C-s" . consult-line)
         ;; Search backward
         ("C-r" . consult-line-backward)
         ;; Switch to another buffer, or bookmarked file, or recently opened file
         ("C-x b" . consult-buffer)))

(provide 'slp-consult)
;;; config.el ends here
