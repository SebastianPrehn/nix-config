;;; general/config.el --- More convenient key definitions in Emacs -*- lexical-binding: t -*-
;;; Commentary:

;;; Code:

(use-package general
  :demand t
  :config
  (general-evil-setup) ;; integrate general with evil
  ;; set up 'SPC' as the global leader key
  (general-create-definer slp/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode
  ;; set up ',' as the local leader key
  (general-create-definer slp/local-leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "," ;; set local leader
    :global-prefix "M-,") ;; access local leader in insert mode
  (general-define-key
   :states 'insert
   "C-g" 'evil-normal-state) ;; don't stretch for ESC
  ;; unbind some annoying default bindings
  (general-unbind
    "C-x C-r"   ;; unbind find file read only
    "C-x C-z"   ;; unbind suspend frame
    "C-x C-d"   ;; unbind list directory
    "<mouse-2>") ;; pasting with mouse wheel click
  (slp/leader-keys
   "SPC" '(execute-extended-command :wk "execute command") ;; an alternative to 'M-x'
   "TAB" '(:keymap tab-prefix-map :wk "tab")) ;; remap tab bindings
  (slp/leader-keys
   "w" '(:keymap evil-window-map :wk "window")) ;; window bindings
  ;; help
  ;; namespace mostly used by 'helpful'
  (slp/leader-keys
    "hc" '(helpful-command :wk "helpful command")
    "hf" '(helpful-callable :wk "helpful callable")
    "hh" '(helpful-at-point :wk "helpful at point")
    "hF" '(helpful-function :wk "helpful function")
    "hv" '(helpful-variable :wk "helpful variable")
    "hk" '(helpful-key :wk "helpful key"))


  (slp/leader-keys
    "h" '(:ignore :wk "help"))
  ;; file
  (slp/leader-keys
    "f" '(:ignore :wk "file")
    "ff" '(find-file :wk "find file") ;; gets overridden by consult
    "fs" '(save-buffer :wk "save file"))
  ;; buffer
  ;; see 'bufler' and 'popper'
  (slp/leader-keys
    "b" '(:ignore :wk "buffer")
    "bb" '(switch-to-buffer :wk "switch buffer") ;; gets overridden by consult
    "bk" '(kill-this-buffer :wk "kill this buffer")
    "br" '(revert-buffer :wk "reload buffer"))
  ;; bookmark
  (slp/leader-keys
    "B" '(:ignore :wk "bookmark")
    "Bs" '(bookmark-set :wk "set bookmark")
    "Bj" '(bookmark-jump :wk "jump to bookmark"))

  ;; universal argument
  (slp/leader-keys
   "u" '(universal-argument :wk "universal prefix"))
  ;; notes
  ;; see 'citar' and 'org-roam'
  (slp/leader-keys
    "n" '(:ignore :wk "notes")
    ;; see org-roam and citar sections
    "na" '(org-todo-list :wk "agenda todos")) ;; agenda

  ;; code
  ;; see 'flymake'
  (slp/leader-keys
    "c" '(:ignore :wk "code"))

  ;; open
  (slp/leader-keys
    "o" '(:ignore :wk "open")
    "os" '(speedbar :wk "speedbar")
    "oe" '(elfeed :wk "elfeed"))

  ;; search
  ;; see 'consult'
  (slp/leader-keys
    "s" '(:ignore :wk "search"))

  ;; templating
  ;; see 'tempel'
  (slp/leader-keys
    "t" '(:ignore :wk "template")))


(provide 'slp-general)
;;; config.el ends here
