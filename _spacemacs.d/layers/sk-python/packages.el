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
      )))
