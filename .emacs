(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; Backups to Temp Folder please
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Tab behaviour
(setq c-basic-indent 2)
(setq tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))
(setq indent-tabs-mode nil)
;(highlight-tabs)
;(highlight-trailing-whitespace)


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
(setq-default TeX-master nil)


(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

(setq TeX-PDF-Mode 1)


;;enable syntax highlighting
(global-font-lock-mode t)
(transient-mark-mode 1)
(setq auto-mode-alist
      (append
		       '(("\\.pl" . prolog-mode))
		       auto-mode-alist))
(setq prolog-program-name "swipl")
(setq prolog-consult-string "[user].\n")

(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))


;; Load org mode settings

(require 'orgsettings)


;; Disable vc.git
(eval-after-load "vc" '(remove-hook 'find-file-hooks 'vc-find-file-hook))

;; ;;
;; ;;
;; ;; Haskell Mode
;; ;;
;; ;;


;;    (load "~/.local/haskellmode/haskell-site-file")
;;    (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

;;    ;; The three indent modules are mutually exclusive
;;    (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;    ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;    ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)


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








;; My own key-bindings
(global-set-key (kbd "C-x n") 'make-frame)
(global-set-key (kbd "C-c C-f") 'find-file)






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




;;color theme
;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-arjen)


;; Load system specific settings 
(cond ((eq system-type 'windows-nt) (load-library "nt"))
      ((eq system-type 'gnu/linux) (load-library "linux"))
      (t (load-library "default")))
(system-specific-setup)

(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
           (add-to-list 'default-frame-alist (cons 'width 120))
           (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
         (cons 'height (/ (- (x-display-pixel-height) 200)
                             (frame-char-height)))))))

(set-frame-size-according-to-resolution)


;; some configs Stevey's .emacs file
;; (eshell)
;; (setq ansi-color-names-vector ; better contrast colors
;;       ["black" "red4" "green4" "yellow4"
;;        "blue3" "magenta4" "cyan4" "white"])
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(setq TeX-PDF-mode t)

(message "Loaded .emacs")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/.org/college.org" "~/.org/personal.org" "~/.org/hobbies.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)



(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

(require 'surround)
(global-surround-mode 1)
