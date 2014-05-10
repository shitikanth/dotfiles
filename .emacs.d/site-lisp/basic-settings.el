;;; basic-settings.el --- My basic customizations and settings

;;
;; Start server
(require 'server)
(when (and (functionp 'server-running-p) (not (server-running-p)))
  (server-start))

;;
;; File behaviour
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
; (setq make-backup-files nil)	; disable backups
(auto-compression-mode t)


;;
;; Gui settings
(tool-bar-mode 0)
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t
      fill-column-mode 81)

;;
;; Use package manager 
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa")
(add-to-list 'package-archives 
    '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives 
    '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives 
    '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;;
;; Editing behaviour
(auto-insert-mode t)			; provide templates for new files


;;
;; Options
; (iswitchb-mode t)			; fast way to switch buffers
(ido-mode t)				; even faster
(setq diary-file "~/.emacs.d/diary")

;;
;; Enable disabled commands

(put 'downcase-region  'disabled nil)   ; Let downcasing work
(put 'erase-buffer     'disabled nil)
(put 'eval-expression  'disabled nil)   ; Let ESC-ESC work
(put 'narrow-to-page   'disabled nil)   ; Let narrowing work
(put 'narrow-to-region 'disabled nil)   ; Let narrowing work
(put 'set-goal-column  'disabled nil)
(put 'upcase-region    'disabled nil)   ; Let upcasing work

;;
;; Personal information
(setq user-full-name "Shitikanth Kashyap"
      user-mail-address "shitikanth1@gmail.com")

(provide 'basic-settings)
;;; basic-settings.el ends here


