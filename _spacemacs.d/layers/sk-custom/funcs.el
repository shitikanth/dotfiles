;; Notes

(defun sk/emacs-notes ()
  "Open emacs notes."
  (interactive)
  (find-file "~/Dropbox/Notes/programming/emacs.org"))

(defun sk/find-notes ()
  "Search file in notes."
  (interactive)
  (find-file "~/Dropbox/Notes")
  (call-interactively 'projectile-find-file))

;; Layout
(defun sk/layout-two-windows()
  "Set the layout to double columns and populate them with
    three recent buffers."
  (interactive)
  (delete-other-windows)
  (split-window-right)
  (switch-to-buffer-other-window (other-buffer))
  (other-window 1)
  )

(defun sk/layout-three-windows ()
  "Set the layout to three windows in a T and populate them
    with three recent buffers."
  (interactive)
  (delete-other-windows)
  (split-window-right)
  (other-window 1)
  (switch-to-buffer (other-buffer))
  (split-window-vertically)
  (other-window 1)
  (switch-to-buffer (other-buffer))
  (other-window 1))


(defun sk/describe-symbol-at-point ()
  "DWIM. Just show symbol at point without showing a prompt."
  (interactive)
  (describe-symbol (symbol-at-point)))

(defun sk/load-ssh-environment ()
  (interactive)
  (with-temp-buffer
    (insert-file-contents "~/.ssh/environment")
    (re-search-forward "SSH_AUTH_SOCK=\\([^ ]*\\);")
    (setenv "SSH_AUTH_SOCK" (match-string 1))
    (re-search-forward "SSH_AGENT_PID=\\([^ ]*\\);")
    (setenv "SSH_AGENT_PID" (match-string 1))))
