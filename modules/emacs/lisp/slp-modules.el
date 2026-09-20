;;; slp-modules.el --- Module setup -*- lexical-binding: t -*-

(defvar slp/modules-directory
  (expand-file-name "modules/" user-emacs-directory)
  "Root directory for all modules.")

(defvar slp/enabled-modules '()
  "List of enabled modules as (CATEGORY . NAME) pairs.")

(defun slp/module-path (category name &optional file)
  "Return the path for MODULE in CATEGORY, optionally to FILE within it."
  (expand-file-name
   (concat (symbol-name category) "/"
           (symbol-name name) "/"
           (or file ""))
   slp/modules-directory))

(defun slp/module-p (category name)
  "Return t if (CATEGORY NAME) module is enabled."
  (member (cons category name) slp/enabled-modules))

(defmacro slp/when-module (category name &rest body)
  "Evaluate BODY only if (CATEGORY NAME) module is enabled.
Useful for cross-module dependencies."
  (declare (indent 2))
  `(when (slp/module-p ',category ',name)
     ,@body))

(defun slp/load-module (category name)
  "Load a single module given CATEGORY and NAME symbols."
  (let ((config (slp/module-path category name "config.el")))
    (if (file-exists-p config)
        (progn
          (push (cons category name) slp/enabled-modules)
          (load config nil 'nomessage))
      (warn "slp/modules: module %s/%s has no config.el" category name))))

(defmacro slp/modules! (&rest module-list)
  "Enable and load a list of modules.

Usage:
  (slp/modules!
   :editor meow
   :ui     theme
   :tools  git)"
  (let (forms
        current-category)
    (dolist (item module-list)
      (if (keywordp item)
          (setq current-category (intern (substring (symbol-name item) 1)))
        (push `(slp/load-module ',current-category ',item) forms)))
    `(progn ,@(nreverse forms))))

(provide 'slp-modules)
;;; slp-modules.el ends here
