;;; general/config.el --- More convenient key definitions in Emacs -*- lexical-binding: t -*-

;;; Commentary:

;; Sets up `SPC' (global) and `,' (local) leader keys, and the layout
;; of the global leader map: the top-level prefix groups, plus bindings
;; for built-in commands.
;;
;; Package-specific bindings live in each package's module, wrapped in
;; `slp/when-module' so they disappear with the module.
;;
;; Those modules must load after this one in `slp/modules!'.

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

  ;; Top-level prefix groups. Modules add keys under these.
  (slp/leader-keys
    "b" '(:ignore t :wk "buffer")
    "B" '(:ignore t :wk "bookmark")
    "c" '(:ignore t :wk "code")
    "e" '(:ignore t :wk "envrc")
    "f" '(:ignore t :wk "file")
    "h" '(:ignore t :wk "help")
    "n" '(:ignore t :wk "notes")
    "o" '(:ignore t :wk "open")
    "s" '(:ignore t :wk "search")
    "t" '(:ignore t :wk "template"))

  ;; Built-in commands
  (slp/leader-keys
   "SPC" '(execute-extended-command :wk "execute command") ;; an alternative to 'M-x'
   "TAB" '(:keymap tab-prefix-map :wk "tab") ;; remap tab bindings
   ;; evil loads before general, so its leader bindings live here
   "w" '(:keymap evil-window-map :wk "window")
   "u" '(universal-argument :wk "universal prefix")

   "ff" '(find-file :wk "find file")
   "fs" '(save-buffer :wk "save file")

   "bb" '(switch-to-buffer :wk "switch buffer") ;; replaced by consult-buffer
   "bk" '(kill-current-buffer :wk "kill this buffer")
   "br" '(revert-buffer :wk "reload buffer")

   "Bs" '(bookmark-set :wk "set bookmark")
   "Bj" '(bookmark-jump :wk "jump to bookmark")))

(provide 'slp-general)
;;; config.el ends here
