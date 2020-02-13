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

(defun sk/ag-notes ()
  "Search in notes (ignores html files by default)."
  (interactive)
  (counsel-ag nil "~/Dropbox/Notes" "--ignore \"*.html*\" --ignore \"*.js\" --ignore \"*.css\" " "Search"))

(defun sk/find-init-file ()
  "Open init file for editing."
  (interactive)
  (find-file user-init-file))

(defun sk/describe-symbol-at-point ()
  "DWIM. Just show symbol at point without showing a prompt."
  (interactive)
  (describe-symbol (symbol-at-point)))

(defun sk/dired-open-file ()
  "In dired, open the file named on this line."
  (interactive)
  (let* ((file (dired-get-filename nil t)))
    (when file
      (shell-command (format "nohup xdg-open \"%s\" > /dev/null < /dev/null &" file)))))

(defun sk/revert-buffer-confirm-if-modified ()
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer t (not (buffer-modified-p))))

(defun sk/ref-download-url (url)
  (interactive "surl to download:")
  (save-excursion
    (bibtex-beginning-of-entry)
    (let* ((bibtex-expand-strings t)
           (entry (bibtex-parse-entry t))
           (key (reftex-get-bib-field "=key=" entry))
           (pdf (concat org-ref-pdf-directory key ".pdf")))
      (message "pdf: %s" pdf)
      (url-copy-file url pdf))))


(defun sk/shell-command-on-buffer (command)
  (interactive
   (list (read-shell-command "Shell command on buffer: ")))
  (shell-command-on-region (point-min) (point-max) command))

(defun sk/shell-command-on-buffer (command)
  (interactive
   (list (read-shell-command "Shell command on buffer: ")))
  (shell-command-on-region (point-min) (point-max) command))

(defun sk/pipe-buffer (command)
  (interactive
   (list (read-shell-command "Shell command on buffer: ")))
  (shell-command-on-region (point-min) (point-max) command t t))

(defun sk/occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
			(buffer-substring-no-properties
			 (region-beginning)
			 (region_end))
		  (let ((sym (thing-at-point 'symbol)))
			(when (stringp sym)
			  (regexp-quote sym))))
		regexp-history)
  (call-interactively 'occur))

(defun sk/font-lock-force-reset ()
  (interactive)
  (font-lock-mode -1)
  (font-lock-mode))

(provide 'sk)
;;; sk.el ends here
