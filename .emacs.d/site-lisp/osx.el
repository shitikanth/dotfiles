;; osx.el
;; setting to use on Macbooks
(provide 'osx)
(defun system-specific-setup()
  ; Default font
  (set-default-font "Inconsolata-15")
  
  ;;
  ;; Make Aquamacs behave more like emacs
  ;;
  (osx-key-mode -1)
  (setq
   aquamacs-scratch-file nil                        ; do not save scratch file across sessions
   initial-major-mode 'emacs-lisp-mode              ; *scratch* shows up in emacs-lisp-mode
   )
  (tabbar-mode -1)
  (one-buffer-one-frame-mode -1)
)


