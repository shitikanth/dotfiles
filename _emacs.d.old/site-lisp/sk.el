;;; basic-settings.el --- Misc. Emacs hacks

;; Copyright (C) 2014  Shitikanth Kashyap

;; Author: Shitikanth Kashyap <shitikanth1@gmail.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(defun sk/toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

(defun sk/toggle-window-split ()
  "switch split (Vertical <--> Horizontal)"
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))

(defun sk/emacs-notes ()
  "Open emacs notes."
  (interactive)
  (find-file "~/Dropbox/Notes/programming/emacs.org"))

(defun sk/find-notes ()
  "Search file in notes."
  (interactive)
  (find-file "~/Dropbox/Notes")
  (call-interactively 'projectile-find-file))

(defun sk/ag-notes ()
  "Search in notes."
  (interactive)
  (counsel-ag nil "~/Dropbox/Notes" nil "Search"))

(defun sk/find-init-file ()
  "Open init file for editing."
  (interactive)
  (find-file user-init-file))

;; Layout
(defun sk/layout-two-windows()
  "Set the layout to double columns and populate them with
    three recent buffers."
  (interactive)
  (delete-other-windows)
  (split-window-right)
  (switch-to-buffer-other-window (other-buffer))
  (other-window 1))

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

(defun sk/dired-open-file ()
  "In dired, open the file named on this line."
  (interactive)
  (let* ((file (dired-get-filename nil t)))
    (when file
      (shell-command (format "nohup xdg-open \"%s\" > /dev/null < /dev/null &" file)))))


(defun sk/revert-buffer-confirm-if-modified ()
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer t (not (buffer-modified-p)) t))

(provide 'sk)
;;; sk.el ends here
