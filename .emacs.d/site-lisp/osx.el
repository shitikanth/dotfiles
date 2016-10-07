;; osx.el
;; setting to use on Macbooks
(provide 'osx)

(defun system-specific-setup()
  (interactive)
  (menu-bar-mode)
  (setq mac-option-modifier nil)
  (setq mac-command-modifier 'meta)
  (setq ns-function-modifier 'super) ; set Mac's Fn key to type Hyper


  (add-to-list 'exec-path "/usr/local/bin/")
  (add-to-list 'exec-path "~/.cabal/bin/")

  (add-to-list 'default-frame-alist
               '(font . "Source Code Pro-14"))

  (global-set-key (kbd "C-M-f") 'aquamacs-toggle-full-frame)
  (global-set-key (kbd "M-`") 'other-frame)
  (global-set-key (kbd "M-w") 'delete-frame)
  (global-set-key (kbd "M-c") 'kill-ring-save)
  (message "Loaded settings for osx"))
