;;; consult/config.el --- Enhanced variants of many built-in Emacs commands -*- lexical-binding: t -*-

;;; Commentary:

;; Built-in commands are replaced through remapping, so every key bound to
;; them uses the consult version. Consult-only commands are on the `SPC s'
;; search group.

;;; Code:

(use-package consult
  :bind (([remap switch-to-buffer] . consult-buffer)    ; C-x b, SPC b b
         ([remap bookmark-jump]    . consult-bookmark)  ; SPB B j
         ([remap goto-line]        . consult-goto-line) ; M-g g
         ([remap imenu]            . consult-imenu)
         ;; Search the current buffer. Overrides I-search.
         ("C-s" . consult-line)))

(slp/when-module kbd general
  (slp/leader-keys
    ;; Search the current buffer. Overrides I-search
    "ss" '(consult-line :wk "search buffer")
    ;; A reccursive grep
    "sg" '(consult-grep :wk "grep project")
    ;; Search for file names recursively
    "sf" '(consult-find :wk "find file by name")
    ;; Search through the outline (headings) of the file
    "so" '(consult-outline :wk "outline")
    ;; Search through the imenu entries
    "si" '(consult-imenu :wk "imenu")))

(provide 'slp-consult)
;;; config.el ends here
