;;; early-init.el --- Early init  -*- lexical-binding: t; -*-

(setq gc-cons-threshold (* 128 1024 1024)
      gc-cons-percentage 0.6)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold 50000000
                  gc-cons-percentage 0.1)))

(setq package-enable-at-startup nil)

(modify-all-frames-parameters
 '((ns-transparent-titlebar . t)
   (menu-bar-lines . 0)
   (tool-bar-lines . 0)
   (vertical-scroll-bars . nil)
   (left-fringe . 5)
   (right-fringe . 0)))



