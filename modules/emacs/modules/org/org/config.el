;;; org/config.el --- General settings for Org Mode -*- lexical-binding: t -*-

;;; Commentary:

;; Core Org setup: files, capture templates, agenda views, evil integration,
;; and keybindings.
;;
;; Keys:
;; - `SPC n' (global): agenda, capture, links. org-roam and citar add
;;   their own keys under the same prefix.
;; - `,' (local): In Org buffers, TODO state, dates, refile, export.
;;
;; Files live in `org-directory' (~/org/), outside my `nix-config'.

;;; Code:

;;; Files, shared with other Org modules

(setq org-directory (expand-file-name "~/org/"))

(defconst slp/inbox-file (expand-file-name "inbox.org" org-directory)
  "Unsorted captures, refiled later.")

(defconst slp/tasks-file (expand-file-name "tasks.org" org-directory)
  "Personal and study tasks, one heading per project or course.")

(defconst slp/work-file (expand-file-name "work.org" org-directory)
  "Work tasks: one heading per task, clocked while working on it.")

(defconst slp/contacts-file (expand-file-name "contacts.org" org-directory)
  "Contacts, with birthdays and anniversaries for the agenda.")

(defconst slp/bibliography-file
  (expand-file-name "references/bibliography.bib" org-directory)
  "BibTeX bibliography used by org-cite and citar.")

(use-package org
  :ensure nil ; built-in
  :custom
  (org-imenu-depth 7)
  (org-ellipsis " ▼")
  (org-special-ctrl-a/e nil)
  (org-special-ctrl-k nil)
  (org-M-RET-may-split-line '((default . nil)))
  (org-hide-emphasis-markers nil)
  (org-hide-macro-markers nil)
  (org-hide-leading-stars nil)
  (org-cycle-separator-lines 0)
  (org-fold-catch-invisible-edits 'show)
  (org-return-follows-link nil)
  (org-loop-over-headlines-in-active-region 'start-level)
  (org-insert-heading-respect-content t)
  (org-read-date-prefer-future 'time)
  (org-highlight-latex-and-related nil) ; other options affect elisp regexp in src blocks
  (org-fontify-quote-and-verse-blocks t)
  (org-fontify-whole-block-delimiter-line t)
  (org-track-ordered-property-with-tag t)
  (org-structure-template-alist
   '(("s" . "src")
     ("e" . "src emacs-lisp")
     ("E" . "src emacs-lisp :results value code :lexical t")
     ("t" . "src emacs-lisp :tangle FILENAME")
     ("T" . "src emacs-lisp :tangle FILENAME :mkdirp yes")
     ("x" . "example")
     ("X" . "export")
     ("q" . "quote")))

  ;; States. W@/! = ask for a note when entering WAITING. timestamp
  ;; when leaving it; d! = timestamp when done; c@ = note why cancelled.
  (org-todo-keywords
   '((sequence "TODO(t)" "NEXT(n)" "WAITING(w@/!)" "|" "DONE(d!)" "CANCELLED(c@)")))
  (org-log-into-drawer t) ; state notes and clocks go in :LOGBOOK:

  ;; Focus vs quick
  (org-tag-alist
   '((:startgroup)
     ("focus" . ?f)
     ("quick" . ?q)
     (:endgroup)
     ("ticket" . ?t)
     ("project" . ?p)))


  ;; Effort estimates, offered as a fixed list
  (org-global-properties
   '(("Effort_ALL" . "0:15 0:30 1:00 1:30 2:00 3:00")))

  ;; Refiling from the inbox: any heading up to level 2 in the agenda
  ;; files, picked with vertico as file/heading paths.
  (org-refile-targets '((org-agenda-files :maxlevel . 2)))
  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)
  (org-refile-allow-creating-parent-nodes 'confirm)

  ;; Clocking
  (org-clock-persist 'history) ; remember clock history across restarts
  (org-clock-out-remove-zero-time-clocks t)

  :config
  (org-clock-persistence-insinuate)

  (setq org-agenda-files (list slp/inbox-file slp/tasks-file
                               slp/work-file slp/contacts-file))

  (setq org-capture-templates
        `(("i" "Inbox" entry (file ,slp/inbox-file)
           "* TODO %?\n%U\n")

          ("t" "Task" entry (file+headline ,slp/tasks-file "Tasks")
           "* TODO %^{Task} %^g\n%^{Effort}p%U\n%?"
           :empty-lines 1)

          ("f" "Focus work (2h)" entry (file+headline ,slp/tasks-file "Tasks")
           "* TODO %^{Task} :focus:\nSCHEDULED: %^t\n:PROPERTIES:\n:Effort: 2:00\n:END:\n%U\n"
           :empty-lines 1)

          ("q" "Quick work (15m)" entry (file+headline ,slp/tasks-file "Tasks")
           "* TODO %^{Task} :quick:\n:PROPERTIES:\n:Effort: 0:15\n:END:\n"
           :empty-lines 1)

          ("c" "Work ticket" entry (file+headline ,slp/work-file "Tickets")
           "* NEXT [%^{Ticket number}] %^{Title} :ticket:\n:PROPERTIES:\n:TICKET: %\\1\n:REQUESTER: %^{Requester (colleague/user)}\n:END:\n%U\n%?"
           :clock-in t :clock-keep t)

          ("p" "Work project" entry (file+headline ,slp/work-file "Projects")
           "* TODO %^{Project} [/] :project:\n:PROPERTIES:\n:COOKIE_DATA: todo\n:END:\n#+BEGIN: clocktable :scope subtree :maxlevel 4\n#+END:\n** NEXT %?\n")

          ("s" "Sub-item of what I'm clocked into" entry (clock)
           "* NEXT %^{What}\n%U\n%?"
           :clock-in t :clock-keep t)

          ("n" "Note on current ticket/task" item (clock)
           "%U %?")))

  (setq org-agenda-custom-commands
        '(("w" "Overview"
           ((agenda "" ((org-agenda-span 'day)
                        (org-agenda-overriding-header "📅 Today")))
            (tags-todo "focus/NEXT|TODO"
                       ((org-agenda-overriding-header "🧠 Focus work")
                        (org-agenda-sorting-strategy '(todo-state-down priority-down effort-down))))
            (tags-todo "quick/NEXT|TODO"
                       ((org-agenda-overriding-header "📋 Quick work")
                        (org-agenda-sorting-strategy '(todo-state-down priority-down effort-up))))
            (alltodo ""
                     ((org-agenda-files (list slp/inbox-file))
                      (org-agenda-overriding-header "📥 Inbox (refile me)"))))
           ((org-agenda-prefix-format " %i %-12:c [%e] ")))

          ("W" "Work day"
           ((agenda "" ((org-agenda-span 'day)
                        (org-agenda-show-log t)
                        (org-agenda-log-mode-items '(closed clock state))
                        (org-agenda-overriding-header "📅 Today (incl. what I did)")))
            (todo "WAITING" ((org-agenda-overriding-header "⏳ Waiting on others")))
            (tags-todo "ticket/NEXT|TODO" ((org-agenda-overriding-header "📂 Open tickets")))
            (tags-todo "project/NEXT|WAITING" ((org-agenda-overriding-header "📦 Projects")))))

          ("n" "Next 7 Days"
           agenda ""
           ((org-agenda-span 7)
            (org-agenda-overriding-header "📅 Week ahead"))))))


;;; Evil keys in Org and agenda buffers (evil-collection doesn't cover Org)

(slp/when-module editor evil
  (use-package evil-org
    :hook (org-mode . evil-org-mode)
    :config
    (require 'evil-org-agenda)
    (evil-org-agenda-set-keys)))


;;; Keybindings

(slp/when-module kbd general
  (slp/leader-keys
    "na" '(org-agenda :wk "agenda")
    "nt" '(org-todo-list :wk "all TODOs")
    "nc" '(org-capture :wk "capture")
    "nL" '(org-store-link :wk "store link")
    "nj" '(org-clock-goto :wk "jump to clocked task"))

  (with-eval-after-load 'org
    (slp/local-leader-keys
      :keymaps 'org-mode-map
      "t" '(org-todo :wk "TODO state")
      "s" '(org-schedule :wk "schedule")
      "d" '(org-deadline :wk "deadline")
      "E" '(org-set-effort :wk "effort")
      "p" '(org-set-property :wk "set property")
      "q" '(org-set-tags-command :wk "tags")
      "r" '(org-refile :wk "refile")
      "l" '(org-insert-link :wk "insert link")
      "i" '(org-clock-in :wk "clock in")
      "o" '(org-clock-out :wk "clock out")
      "e" '(org-export-dispatch :wk "export"))))

(provide 'slp-org)
;;; config.el ends here
