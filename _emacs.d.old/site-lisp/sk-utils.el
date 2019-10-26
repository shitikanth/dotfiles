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

(defun sk/load-ssh-environment ()
  (interactive)
  (with-temp-buffer
    (insert-file-contents "~/.ssh/environment")
    (re-search-forward "SSH_AUTH_SOCK=\\([^ ]*\\);")
    (setenv "SSH_AUTH_SOCK" (match-string 1))
    (re-search-forward "SSH_AGENT_PID=\\([^ ]*\\);")
    (setenv "SSH_AGENT_PID" (match-string 1))))

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

(provide 'sk-utils)
;;; sk-utils.el ends here
