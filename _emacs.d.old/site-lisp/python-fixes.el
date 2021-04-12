;;; python-fixes.el --- Fixes for python mode        -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Shitikanth Kashyap

;; Author: Shitikanth Kashyap <shitikanth1@gmail.com>
;; Keywords: languages

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

;;; Code:

(require 'python)
(make-variable-buffer-local
 (defvar python--last-python-buffer nil))

;; * Keep track of last python buffer
(defun python--maybe-remember-python-buffer (buffer)
  (when (and buffer
	     (eq 'python-mode (with-current-buffer buffer major-mode))
	     (eq 'inferior-python-mode major-mode))
    (setq python--last-python-buffer buffer)))

(defun python-shell--tracing-function (orig-fun &rest args)
  (let ((buf (current-buffer))
	(res (apply orig-fun args)))
    (python--maybe-remember-python-buffer buf)
    res))

(advice-add 'python-shell-switch-to-shell :around #'python-shell--tracing-function)
(advice-add 'run-python :around #'python-shell--tracing-function)

(defun python-shell-switch-to-python-buffer ()
  (interactive)
  (when (buffer-live-p python--last-python-buffer)
    (pop-to-buffer python--last-python-buffer)))

(define-key inferior-python-mode-map
  (kbd "C-c C-z") #'python-shell-switch-to-python-buffer)

;; * Fix for python-shell-switch-to-shell
(defun python-shell-switch-to-shell (&optional msg)
  "Switch to inferior Python process buffer.
When optional argument MSG is non-nil, forces display of a
user-friendly message if there's no process running; defaults to
t when called interactively."
  (interactive "p")
  (pop-to-buffer
   (process-buffer (python-shell-get-process-or-error msg)) nil 'mark-for-redisplay))

(provide 'python-fixes)
;;; python-fixes.el ends here
