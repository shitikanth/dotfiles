(provide 'plugin-settings)

;;
;; Use package manager 
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa")
(add-to-list 'package-archives 
    '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives 
    '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;;
;; Surround mode
(require 'surround)
(global-surround-mode 1)

