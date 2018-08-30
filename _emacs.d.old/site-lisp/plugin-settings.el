(provide 'plugin-settings)

;;
;; Bootstrap use-package
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; List of packages I want to install automatically
(setq package-list
      '(avy
	ivy
	counsel
	auctex
	org-plus-contrib
	undo-tree
	evil
	evil-surround
	paredit
	projectile
	which-key
	eyebrowse
	realgud
	diminish
	))


(require 'cl-lib)
;; check if all packages are installed already
(defun packages-installed-p ()
  (cl-loop for pkg in package-list
	   when (not (package-installed-p pkg)) do (cl-return nil)
	   finally (cl-return t)))

;; install the missing packages
(unless (packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (package package-list)
    (unless (package-installed-p package)
      (package-install package))))

;;
;; Package settings

;; Projectile mode
(require 'projectile)
(projectile-mode 1)
(setq projectile-indexing-method 'native)
(setq projectile-enable-caching t)

;; Load Paredit automatically
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(when (require 'paredit nil :noerror)
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'scheme-mode-hook           #'enable-paredit-mode))

;; Surround mode
(require 'evil-surround)
(global-evil-surround-mode 1)

;; Haskell mode
(setq haskell-process-show-debug-tips nil)
(eval-after-load "haskell-mode"
  '(progn
     (define-key haskell-mode-map (kbd "C-x C-d") nil)
     (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
     (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
     (define-key haskell-mode-map (kbd "C-c C-b") 'haskell-interactive-switch)
     (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
     (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
     (define-key haskell-mode-map (kbd "C-c M-.") nil)
     (define-key haskell-mode-map (kbd "C-c C-d") nil)))

;; C/C++
(setq c-default-style "linux")
(defun sk/c-c++-settings ()
  (toggle-truncate-lines 1) ; disable 'word-wrap'
  (whitespace-mode 1)
  (setq whitespace-space-regexp "\\(  +\\)") ; only highlight mutliple spaces
  (whitespace-toggle-options '(lines tabs newline-mark space-mark))
  )


(add-hook 'c-mode-hook 'sk/c-c++-settings)
(add-hook 'c++-mode-hook 'sk/c-c++-settings)

;; Ivy/counsel
(require 'ivy)
(ivy-mode 1)

(require 'counsel)
(require 'counsel-projectile)
(counsel-mode 1)
(counsel-projectile-mode 1)
(global-set-key (kbd "C-x j") 'counsel-semantic-or-imenu)

;; Avy
(require 'avy)
(global-set-key (kbd "C-;") 'avy-goto-word-1)

;; Recentf mode
(require 'recentf)
(recentf-mode 1)
(global-set-key (kbd "C-x C-r") 'counsel-recentf)


;; w3m
(setq w3m-user-agent "Mozilla/5.0 (Linux; U; Android 2.3.3; zh-tw; HTC_Pyramid Build/GRI40) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.")
(setq w3m-home-page "http://en.m.wikipedia.org")
(setq w3m-default-display-inline-images t)
(eval-after-load "w3m-search"
  '(progn (add-to-list 'w3m-search-engine-alist
		       '("Qt Docs"
			 "http://doc.qt.io/qt-5/search-results.html?q=%s"
			 nil))
	  (add-to-list 'w3m-uri-replace-alist
		       '("\\`wi:" w3m-search-uri-replace "en.wikipedia"))
	  (add-to-list 'w3m-search-engine-alist
		       '("DuckDuckGo"
			 "https://duckduckgo.com/html/?q=%s"))
	  (add-to-list 'w3m-uri-replace-alist
		       '("\\`dd:" w3m-search-uri-replace "DuckDuckGo"))
	  (setq w3m-search-default-engine "DuckDuckGo")))

;; which-key
(which-key-mode 1)

;; window management
(require 'winner)
(winner-mode 1)

(require 'eyebrowse)
(eyebrowse-mode 1)

(setq eyebrowse-wrap-around t)
(define-key eyebrowse-mode-map (kbd "C-c C-w C-n") 'eyebrowse-next-window-config)
(define-key eyebrowse-mode-map (kbd "C-c C-w C-p") 'eyebrowse-prev-window-config)

;; diminish (clean up the mode line)
(require 'diminish)
(diminish 'projectile-mode)
(diminish 'undo-tree-mode)
(diminish 'counsel-mode)
(diminish 'ivy-mode)
(diminish 'which-key-mode)
(diminish 'eldoc-mode)

;; fix xref-find-references
(add-to-list 'xref-prompt-for-identifier 'xref-find-references t)

;; Quadeye specific files
(require 'qe nil t)
