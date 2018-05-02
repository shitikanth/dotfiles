(defun sk-org/update-log-summary ()
  (interactive)
  (save-excursion
    (org-link-search "Log Summary")
    (next-line)
    (org-clock-report)))
