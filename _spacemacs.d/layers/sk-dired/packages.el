(setq sk-dired-packages
      '(dired
        (dired+ :location local)
        (dired-x :location built-in)))

(defun sk-dired/init-dired+ ()
  (use-package dired+
    :config
    (add-to-list 'font-lock-maximum-decoration '(dired-mode . 1))))

(defun sk-dired/post-init-dired ()
  (add-hook 'dired-mode-hook 'sk/dired-mode-setup)
  (spacemacs|define-custom-layout "@Dired"
    :binding "d"
    :body (sk-dired/init-two-column-view)))

(defun sk-dired/post-init-dired-x ()
  (require 'dired-x)
  (setq-default dired-omit-files
                "^\\.?#\\|^\\.\\|^NTUSER.DAT\\|^ntuser.dat")
  (define-globalized-minor-mode
    global-dired-omit-mode dired-omit-mode sk/dired-omit-if-dired)
  (global-dired-omit-mode 1)
  (define-key dired-mode-map (kbd ".") 'dired-omit-mode))

(defun sk/dired-mode-setup ()
  (dired-hide-details-mode 1))

(defun sk/dired-omit-if-dired ()
  "In Dired mode enable omit mode. Outside Dired, do nothing."
  (when (derived-mode-p 'dired-mode) (dired-omit-mode 1)))
