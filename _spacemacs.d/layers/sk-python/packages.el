(setq sk-python-packages
  '(
    (python :location built-in)
    ))

(defun sk-python/init-python ()
  (use-package python
    :defer t
    :config
    (progn
      (spacemacs/set-leader-keys-for-major-mode 'python-mode
        "gn" 'python-nav-forward-defun
        "gp" 'python-nav-backward-defun)
      (define-key python-mode-map
        (kbd "M-n") 'python-nav-forward-defun)
      (define-key python-mode-map
        (kbd "M-p") 'python-nav-backward-defun)
      (define-key python-mode-map
        (kbd "C-c C-z") 'sk/python-shell-switch-to-shell)
      (define-key inferior-python-mode-map
        (kbd "C-c C-z") 'sk/python-switch-last-python-buffer)
      )))

(defun sk/python-shell-switch-to-shell (&optional msg)
  "Switch to inferior Python process buffer using
  `python-shell-switch-to-shell'. Remember the current buffer as
  `sk/last-python-buffer'."
  (interactive)
  (let ((buffer (current-buffer)))
    (python-shell-switch-to-shell)
    (setq sk/last-python-shell buffer)
    ))


(defun sk/python-switch-last-python-buffer ()
  "Switch to the last Python buffer."
  (interactive)
  (cond
   ((not (derived-mode-p 'inferior-python-mode))
    (message "Not in Python shell"))
   ((not (buffer-live-p sk/last-python-shell))
    (message "Don't know the original Python buffer"))
   (t (pop-to-buffer sk/last-python-shell))))
