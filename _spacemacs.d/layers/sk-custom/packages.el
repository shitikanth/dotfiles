(defconst sk-custom-packages
  '(
    (dired+ :location local)
    (dired-x :location built-in)
    ))

(defun sk-custom/init-dired+ ()
  (use-package dired+
    :defer t
    :config
    (add-to-list 'font-lock-maximum-decoration '(dired-mode . 1)))
  )

(defun sk-custom/post-init-dired-x ()
  (require 'dired-x)
  (define-globalized-minor-mode
    global-dired-omit-mode dired-omit-mode sk/dired-omit-if-dired)
  (global-dired-omit-mode 1)
  (define-key dired-mode-map (kbd ".") 'dired-omit-mode)
  )

(defun sk/dired-omit-if-dired ()
  "In Dired mode enable omit mode. Outside Dired, do nothing."
  (when (derived-mode-p 'dired-mode) (dired-omit-mode 1)))

