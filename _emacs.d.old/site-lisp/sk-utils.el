;;; sk-utils.el --- utility functions                -*- lexical-binding: t; -*-

;; Copyright (C) 2019  Shitikanth Kashyap

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
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

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

(defun sk/ag-notes ()
  "Search notes."
  (interactive)
  (counsel-ag nil "~/Dropbox/Notes" "--ignore \"*.html*\" --ignore \"*.js\" --ignore \"*.css\""))

;; Misc
(defun sk/load-ssh-environment ()
  (interactive)
  (with-temp-buffer
    (insert-file-contents "~/.ssh/environment")
    (re-search-forward "SSH_AUTH_SOCK=\\([^ ]*\\);")
    (setenv "SSH_AUTH_SOCK" (match-string 1))
    (re-search-forward "SSH_AGENT_PID=\\([^ ]*\\);")
    (setenv "SSH_AGENT_PID" (match-string 1))))

(defun sk/rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(provide 'sk-utils)
;;; sk-utils.el ends here
