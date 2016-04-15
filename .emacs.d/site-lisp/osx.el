;; osx.el
;; setting to use on Macbooks
(provide 'osx)

(defun aquamacs-settings()
  ;;
  ;; Make Aquamacs behave more like emacs
  ;;
  (osx-key-mode -1)
  (setq
   aquamacs-scratch-file nil                ; do not save scratch file across sessions
   initial-major-mode 'emacs-lisp-mode      ; *scratch* shows up in emacs-lisp-mode
   )
  (aquamacs-autoface-mode -1)
  (tabbar-mode -1)
  (tool-bar-mode -1)
  (one-buffer-one-frame-mode -1)
  (set-face-attribute 'echo-area nil :family 'unspecified)  ; show echo area in Monaco
  (set-face-attribute 'mode-line nil :inherit 'unspecified) ; show modeline in Monaco
  )


(defun system-specific-setup()
  (interactive)
  ;(if (boundp 'aquamacs-version)
  ;    (aquamacs-settings))
  (menu-bar-mode)
  (setq mac-option-modifier nil)
  (setq mac-command-modifier 'meta)
  (setq ns-function-modifier 'super) ; set Mac's Fn key to type Hyper


  (add-to-list 'exec-path "/usr/local/bin/")
  (add-to-list 'exec-path "~/.cabal/bin/")

  ;; (add-to-list 'default-frame-alist
  ;;              '(font . "Inconsolata-14"))

  (set-default-font "Monaco-11")

  (global-set-key (kbd "C-M-f") 'aquamacs-toggle-full-frame)
  (global-set-key (kbd "M-`") 'other-frame)
  (global-set-key (kbd "M-w") 'delete-frame)
  (global-set-key (kbd "M-c") 'kill-ring-save)
  (message "Loaded settings for osx")
)
