;;; orderless/config.el --- Out-of-order pattern matching in the minibuffer -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package orderless
  :demand t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil)
  (orderless-ignore-case t))

(provide 'slp-orderless)
;;; config.el ends here
