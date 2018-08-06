(defun sk-org/update-log-summary ()
  (interactive)
  (save-excursion
    (org-link-search "Log Summary")
    (next-line)
    (org-clock-report)))


(defun sk-org/insert-link-mru-info ()
  (interactive)
  (let*
      ((info-buffer-p (lambda (buf) (with-current-buffer buf (if (eq major-mode 'Info-mode) buf))))
       (mru-info-buffer (cl-some info-buffer-p (buffer-list))))
    (when mru-info-buffer
      (org-insert-link nil (with-current-buffer mru-info-buffer (format "info:%s#%s" (file-name-nondirectory Info-current-file) Info-current-node))))))


(defun sk-org/inbox ()
  (interactive)
  (find-file org-default-notes-file))
