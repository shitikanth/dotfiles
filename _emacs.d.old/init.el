(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))

(package-initialize)

(add-to-list 'load-path (concat user-emacs-directory "site-lisp"))
(setq custom-file (concat user-emacs-directory "custom.el"))

;; Load settings from config files in .emacs.d/site-lisp
(mapc
 'require
 '(basic-settings
   plugin-settings
   org-settings
   keybindings
   system
   misc-hacks))


;; Theme
(load-theme 'adwaita)

;; Start server if not running
(require 'server)
(unless (server-running-p) (server-start))

;; Start with agenda mode
(org-agenda-list)
(delete-other-windows)
(message "Loaded .emacs")
