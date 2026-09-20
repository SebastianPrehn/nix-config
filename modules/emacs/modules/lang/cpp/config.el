;;; cpp/config.el --- C/C++ plus CUDA -*- lexical-binding: t -*-

(use-package c-ts-mode
  :ensure nil
  :demand t
  :config
  (add-to-list 'auto-mode-alist '("\\.cu[h]?\\'" . c++-ts-mode))
  (add-hook 'c++-ts-mode-hook
	    (lambda ()
	      (when (and buffer-file-name
			 (string-match-p "\\.cu[h]?\\'" buffer-file-name))
		(setq-local treesit-language-remap-alist '((cpp . cuda)))))))

(provide 'slp-cpp)
;;; config.el ends here
