;; New leader keys for spacemacs
(spacemacs/set-leader-keys
  "oo" 'helm-themes
  "ov" 'describe-variable
  "of" 'describe-function
  "ob" 'ibuffer-list-buffers
  "on" 'sk/emacs-notes
  "oN" 'sk/find-notes)

;; Layout
(spacemacs/set-leader-keys
  "w2" 'sk/layout-two-windows
  "w3" 'sk/layout-three-windows)

;; global keybindings
(global-set-key (kbd "M-`") 'other-frame)
(global-set-key (kbd "M-<f4>") 'delete-frame)
(global-set-key (kbd "C-x C-b") 'ibuffer-list-buffers)
