(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; Use package manager 
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa")
(add-to-list 'package-archives 
    '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives 
    '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

;;
;; Basic Customization

(setq inhibit-splash-screen t)
(setq search-highlight t)
(setq query-replace-highlight t)

(toggle-scroll-bar -1)
(tool-bar-mode -1)
(set-terminal-coding-system 'iso-latin-1)
(auto-insert-mode t)
(iswitchb-mode 1)

;; Tab behaviour
(setq c-basic-indent 2)
(setq tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))
(setq-default indent-tabs-mode nil)
;;(highlight-tabs) 		  ; could not find definitions
;;(highlight-trailing-whitespace) 

;; Backups to Temp Folder please
(setq backup-directory-alist 
    `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
    `((".*" ,temporary-file-directory t)))

;; Load system specific settings 
(cond 
 ((eq system-type 'windows-nt) (load-library "nt"))
 ((eq system-type 'gnu/linux) (load-library "linux"))
 ((eq system-type 'darwin) (load-library "osx"))
 (t (load-library "default")))
(system-specific-setup)


;; My own key-bindings
(global-set-key (kbd "C-x n") 'make-frame)
(global-set-key (kbd "C-c C-f") 'find-file)
(global-set-key (kbd "C-<f9>") 'previous-buffer)
(global-set-key (kbd "C-<f10>") 'next-buffer)

;; Markdown
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; Mark-region
;(require 'wrap-region)

;; AUCTEX

;(load "auctex.el" nil t t)
;(load "preview-latex.el" nil t t)
(setq TeX-view-program-list '(("Evince" "evince --page-index=%(outpage) %o")))
(setq TeX-view-program-selection '((output-pdf "Evince")))
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master t)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-Mode 1)


;; Disable vc.git
(eval-after-load "vc" '(remove-hook 'find-file-hooks 'vc-find-file-hook))

;;
;; File finder (enter directories by " ")
;;
(defun geosoft-parse-minibuffer () 
   ;; Extension to the complete word facility of the minibuffer 
   (interactive) 
   (backward-char 4) 
   (setq found t) 
   (cond 
      ; local directories 
      ((looking-at "..cd") (setq directory "c:/users/john/")) 
      ((looking-at ".doc") (setq directory "c:/users/john/documents/")) 
      ((looking-at "java") (setq directory "c:/users/john/src/java/")) 
 (t (setq found nil))) 
   (cond (found (beginning-of-line) 
                 (kill-line) 
                 (insert directory)) 
          (t     (forward-char 4) 
                 (minibuffer-complete))))

(define-key minibuffer-local-completion-map " " 'geosoft-parse-minibuffer)


;;; Use "%" to jump to the matching parenthesis.
(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert
the character typed."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
    ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
    (t                    (self-insert-command (or arg 1))) ))
(global-set-key (kbd "C-%") `goto-match-paren)


(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (message "set-frame-size")
    (if
     (> (x-display-pixel-width) 1200)
      (add-to-list 'default-frame-alist (cons 'width 120))
      (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
         (cons 'height (/ (- (x-display-pixel-height) 200)
                             (frame-char-height)))))))

(put 'narrow-to-region 'disabled nil)

;; Load org mode settings
(require 'orgsettings)

;; Surround mode
(require 'surround)
(global-surround-mode 1)

;; Color Theme
(require 'color-theme)
;(eval-after-load "color-theme"
;  '(progn (color-theme-arjen)))

;; Disable vc.git
(eval-after-load "vc" '(remove-hook 'find-file-hooks 'vc-find-file-hook))

(set-frame-size-according-to-resolution)

;; Start with agenda mode
(org-agenda-list)
(delete-other-windows)
;; ^doesn't work on Aquamacs, find a fix

(message "Loaded .emacs")
