(setq emacs-start-time (current-time))

(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))

(add-to-list 'load-path (concat user-emacs-directory "site-lisp"))
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file)

;;
;; My basic customizations and settings
(setq user-full-name "Shitikanth Kashyap"
      user-mail-address "shitikanth1@gmail.com")

(setq make-backup-files nil) ; stop creating ~ files
(setq autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(setq auto-save-list-file-prefix autosave-dir)

;; reduce frequency of garbage collection
(setq gc-cons-threshold 50000000)

;; enable persistent history
(savehist-mode 1)

;; appearance settings
(menu-bar-mode -1)
(line-number-mode 1)
(column-number-mode 1)
(blink-cursor-mode -1)
(when window-system
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (fringe-mode '(5 . 0)))

(setq-default fill-column 80)
(setq inhibit-startup-screen t)
(setq initial-major-mode 'emacs-lisp-mode)

;; utf-8
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Package initialize
(setq sk/start-time (current-time))
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(setq package-enable-at-startup nil)
(package-initialize)
(message "Package initialize: %.3fs" (float-time (time-since sk/start-time)))

;;
;; Bootstrap use-package
(setq sk/start-time (current-time))
(add-to-list 'load-path (concat user-emacs-directory "lib/use-package"))
(require 'use-package)
(message "Bootstrap use-package: %.3fs" (float-time (time-since sk/start-time)))

;;
;; Packages
(setq use-package-verbose t)

(use-package dired
  :config
  (setq dired-auto-revert-buffer t
	dired-dwim-target t))

(use-package ibuffer
  :bind
  ("C-x C-b" . ibuffer)
  :config
  (setq ibuffer-show-empty-filter-groups nil))

(use-package bookmark
  :config
  (setq bookmark-save-flag t))

(use-package imenu
  :config
  (defun imenu-use-package ()
    (add-to-list 'imenu-generic-expression
                 '("Packages" "^\\s-*(\\(use-package\\)\\s-+\\(\\(\\sw\\|\\s_\\)+\\)" 2)))
  (add-hook 'emacs-lisp-mode-hook #'imenu-use-package))

(use-package diminish :ensure t)

(use-package recentf
  :config
  (setq recentf-max-saved-items 500
        recentf-max-menu-items 15
        ;; disable recentf-cleanup on Emacs start, because it can cause
        ;; problems with remote files
        recentf-auto-cleanup 'never)
  (recentf-mode +1))

(use-package ivy
  :defer 1
  :load-path "lib/swiper"
  :diminish
  :bind (("C-z" . ivy-switch-buffer)
	 ("C-c h" . ivy-resume))
  :commands (ivy-switch-buffer ivy-mode)
  :config
  (setq-default ivy-use-virtual-buffers t)
  (ivy-mode 1))

(use-package counsel
  :defer 1
  :load-path "lib/swiper"
  :diminish ivy-mode
  :diminish counsel-mode
  :bind (("C-x b" . counsel-bookmark)
	 ("C-x j" . counsel-semantic-or-imenu))
  :commands (counsel-bookmark counsel-mode)
  :config
  (counsel-mode 1))

(use-package swiper
  :after ivy
  :load-path "lib/swiper"
  :bind (("C-c s" . swiper))
  :bind (:map swiper-map
	      ("C-c ." . swiper-avy)
	      ("C-." . swiper-avy))
  :bind (:map isearch-mode-map
	      ("C-o" . swiper-from-isearch)))

(use-package avy :ensure t
  :commands (avy-goto-char-timer)
  :bind (("C-c ." . avy-goto-char-timer)
	 ("C-." . avy-goto-char-timer)))

(use-package paren
  :defer 1
  :config
  (show-paren-mode 1))

(use-package paredit :ensure t
  :defer 5
  :diminish
  :hook
  ((emacs-lisp-mode . enable-paredit-mode)
   (lisp-mode . enable-paredit-mode)
   (lisp-interaction-mode . enable-paredit-mode)
   (eval-expression-minibuffer-setup . enable-paredit-mode)))

(use-package projectile :ensure t
  :defer 5
  :diminish
  :bind* ("C-c TAB" . projectile-find-other-file)
  :bind-keymap ("C-c p" . projectile-command-map)
  :init
  :config
  (projectile-global-mode)
  (add-to-list 'projectile-globally-ignored-directories ".cquery_cached_index")
  (setq projectile-indexing-method 'native
	projectile-completion-system 'ivy
        projectile-enable-caching t))

(use-package compile
  :preface
  (defun my-compilation-mode-hook ()
    )
  :bind (("C-c c" . compile))
  :hook (compilation-mode . my-compilation-mode-hook))

(use-package cc-mode
  :preface
  (defun my-c-mode-common-hook ()
    (toggle-truncate-lines 1)
    (whitespace-mode 1)
    (setq whitespace-space-regexp "\\(  +\\))")
    (whitespace-toggle-options '(lines tabs newline-mark space-mark)))
  :hook (c-mode-common . my-c-mode-common-hook)
  :config
  (setq c-default-style "linux"))

(use-package cquery :ensure t
  :commands lsp-cquery-enable)

(use-package lsp-mode :ensure t
  :defer t)

(use-package lsp-ui :ensure t
  :defer t)

(use-package magit
  :ensure t
  :commands (magit-status magit-blame)
  :bind ("C-x g" . magit-status))

(use-package eyebrowse :ensure t
  :defer 5
  :custom (eyebrowse-keymap-prefix (kbd "C-x w"))
  :config
  (eyebrowse-mode 1)
  (setq eyebrowse-wrap-around t))

(use-package multiple-cursors
  :defer 5
  :commands (mc/mark-next-like-this mc/mark-previous-like-this)
  :bind (("C->" . mc/mark-next-like-this)
	 ("C-<" . mc/mark-next-like-this)))

(use-package which-key :ensure t
  :defer 1
  :diminish
  :commands which-key-mode
  :config
  (which-key-mode 1))

(use-package winner :ensure t
  :unless noninteractive
  :defer 5
  :config
  (winner-mode 1))

(use-package server
  :defer 1
  :config
  (setq server-name "emacs-old")
  (message "Start server emacs-old")
  (unless (server-running-p)
    (server-start)))

(use-package sk
  :bind
  (("C-c n f" . sk/find-notes)
   ("C-c n n" . sk/ag-notes)
   ("C-c r" . sk/revert-buffer-confirm-if-modified))
  :bind
  (:map dired-mode-map
	("C-c o" . sk/dired-open-file)))

(use-package org-settings)

(use-package help-fns+)


;; local settings
(setq local-settings-file (concat user-emacs-directory "local.el"))
(when (file-exists-p local-settings-file)
  (load-file local-settings-file))

(use-package sk-utils
  :bind
  (("C-c n f" . sk/find-notes)
   ("C-c n n" . sk/ag-notes)))

;; local-settings
(setq local-settings-file (concat user-emacs-directory "local.el"))
(when (file-exists-p local-settings-file)
  (load-file local-settings-file))

(message "Loaded .emacs in %.3fs" (float-time (time-since emacs-start-time)))
