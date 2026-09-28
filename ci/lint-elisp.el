;;; lint-elisp.el --- Byte-compile and indentation checks  -*- lexical-binding: t; -*-

;;; Commentary:

;; Entry point for ci/lint-elisp, which runs
;;
;;   emacs --batch -Q -l ci/lint-elisp.el -f lint-elisp-batch [--fix] FILE...
;;
;; init.el only compiles cleanly with its packages on `load-path'.  Locally
;; they are read from ~/.emacs.d/elpa, which is never written to.  CI points
;; LINT_ELISP_ELPA at a cache directory instead, and every `use-package' in
;; init.el missing from it gets installed there.

;;; Code:

(require 'bytecomp)
(require 'cl-lib)
(require 'package)

(defconst lint-elisp-root
  (file-name-directory
   (directory-file-name (file-name-directory (or load-file-name buffer-file-name)))))

(defun lint-elisp--use-package-names (file)
  "Return the names of the top-level `use-package' forms in FILE."
  (with-temp-buffer
    (insert-file-contents file)
    (let (names)
      (condition-case nil
          (while t
            (let ((form (read (current-buffer))))
              (when (eq (car-safe form) 'use-package)
                (push (cadr form) names))))
        (end-of-file nil))
      (nreverse names))))

(defun lint-elisp--setup-packages ()
  (setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                           ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                           ("melpa" . "https://melpa.org/packages/")))
  (let ((cache (getenv "LINT_ELISP_ELPA")))
    (if cache
        (setq package-user-dir (expand-file-name cache))
      (setq package-user-dir (make-temp-file "lint-elisp-elpa" t)
            package-directory-list (list (locate-user-emacs-file "elpa"))))
    (package-initialize)
    (when cache
      (let ((missing (seq-remove
                      (lambda (name)
                        (or (package-installed-p name)
                            (package-built-in-p name)
                            (locate-library (symbol-name name))))
                      (lint-elisp--use-package-names
                       (expand-file-name "_emacs.d.old/init.el" lint-elisp-root)))))
        (when missing
          (package-refresh-contents)
          (dolist (name missing)
            (when (assq name package-archive-contents)
              (package-install name))))))))

(defun lint-elisp-compile (file)
  "Byte-compile FILE, discarding the output.  Return the number of warnings."
  (let* ((count 0)
         (log byte-compile-log-warning-function)
         (byte-compile-log-warning-function
          (lambda (&rest args)
            (setq count (1+ count))
            (apply log args)))
         (elc (make-temp-file "lint-elisp" nil ".elc"))
         (byte-compile-dest-file-function (lambda (_) elc)))
    (unwind-protect
        (unless (byte-compile-file file)
          (setq count (1+ count)))
      (delete-file elc))
    count))

(defun lint-elisp-indent (file &optional fix)
  "Return the lines of FILE whose indentation is off.
Indentation is off when `indent-region' would change it, or when it
contains a tab.  With FIX, rewrite FILE with those lines corrected."
  (with-temp-buffer
    (insert-file-contents file)
    (emacs-lisp-mode)
    (setq indent-tabs-mode nil)
    (let ((before (split-string (buffer-string) "\n")))
      (goto-char (point-min))
      (while (not (eobp))
        (unless (nth 3 (syntax-ppss))
          (untabify (point) (progn (skip-chars-forward " \t") (point))))
        (forward-line 1))
      (let ((inhibit-message t))
        (indent-region (point-min) (point-max)))
      (let ((lines (cl-loop for old in before
                            for new in (split-string (buffer-string) "\n")
                            for line from 1
                            unless (equal old new) collect line)))
        (when (and fix lines)
          (write-region nil nil file))
        lines))))

(defun lint-elisp-batch ()
  "Check the files left on the command line, then exit.
The exit status is 1 if any file has warnings or indentation off.  A
leading --fix rewrites files with indentation off instead of failing."
  (let ((fix (when (equal (car command-line-args-left) "--fix")
               (pop command-line-args-left)))
        (files command-line-args-left)
        (failed nil))
    (setq command-line-args-left nil)
    (setq ad-redefinition-action 'accept)
    (lint-elisp--setup-packages)
    (add-to-list 'load-path (expand-file-name "_emacs.d.old/site-lisp" lint-elisp-root))
    (dolist (file files)
      (let ((lines (lint-elisp-indent file fix)))
        (dolist (line lines)
          (message "%s:%d: indentation %s" file line (if fix "fixed" "off")))
        (when (and lines (not fix))
          (setq failed t)))
      (when (> (lint-elisp-compile file) 0)
        (setq failed t)))
    (kill-emacs (if failed 1 0))))

;;; lint-elisp.el ends here
