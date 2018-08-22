(defun sk-dired/init-two-column-view ()
  (delete-other-windows)
  (find-file "~")
  (split-window-horizontally))
