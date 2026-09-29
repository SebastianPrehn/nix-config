;;; helpful/config.el --- Richer *Help* buffers -*- lexical-binding: t -*-

;;; Commentary:

;; `helpful' replaces the built-in describe-* help buffers with ones
;; that also show source, references and keybindings. The standard
;; `C-h' keys are remapped, and the same commands are on `SPC h'.

;;; Code:

(use-package helpful
  :demand t
  :bind (([remap describe-function] . helpful-callable)
         ([remap describe-variable] . helpful-variable)
         ([remap describe-key]      . helpful-key)
         ([remap describe-command]  . helpful-command)))

(slp/when-module kbd general
  (slp/leader-keys
    "hc" '(helpful-command :wk "command")
    "hf" '(helpful-callable :wk "callable")
    "hF" '(helpful-function :wk "function")
    "hv" '(helpful-variable :wk "variable")
    "hk" '(helpful-key :wk "key")
    "hh" '(helpful-at-point :wk "thing at point")))

(provide 'slp-helpful)
;;; config.el ends here
