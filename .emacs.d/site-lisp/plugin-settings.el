(provide 'plugin-settings)

;;
;; Use package manager
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa")
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

; List of packages I want to install automatically
(setq package-list
      '(helm
	auctex
	org-plus-contrib
	undo-tree
	evil
	surround
	))

(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;;
;; Surround mode
(require 'surround)
(global-surround-mode 1)

