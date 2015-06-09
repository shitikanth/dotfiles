(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;;
;; Load settings from config files in .emacs.d/site-lisp
(mapc
 'require 
 '(cl
   basic-settings
   misc-hacks
   ; keybindings
   system
   org-settings
   plugin-settings)
)


;;
;; Use color scheme clues
;(load-theme 'clues t)

;; (custom-set-faces
;;  '(ido-subdir ((t (:foreground "#ccccaa"))))      
;;  '(ido-first-match ((t (:foreground "#ccff66")))) 
;;  '(ido-only-match ((t (:foreground "#009945")))) 
;;  '(ido-indicator ((t (:foreground "#ffffcc")))) 
;;  '(ido-incomplete-regexp ((t (:foreground "#ffffcc"))))
;; )


;; Start with agenda mode
(org-agenda-list)
(delete-other-windows)
(message "Loaded .emacs")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("455d6059dfbcd1990350ed5fded17b028d7208e81c644cdb9c84d4b12d99f0fa" "a3d519ee30c0aa4b45a277ae41c4fa1ae80e52f04098a2654979b1ab859ab0bf" "76b226dd750d085eaaf7efa5eb07a3282223d74f327a0f4319512c0a59f6df39" "332955730fca9174f96461664ac7524314f181eefc390ef2fc7bc6cfac9a8573" "7694bfb46ec19cfc47093783633d8cd4df208d620104910bf5c1c840528a8dd1" "4a60f0178f5cfd5eafe73e0fc2699a03da90ddb79ac6dbc73042a591ae216f03" "86f4407f65d848ccdbbbf7384de75ba320d26ccecd719d50239f2c36bec18628" "e80a0a5e1b304eb92c58d0398464cd30ccbc3622425b6ff01eea80e44ea5130e" "0e121ff9bef6937edad8dfcff7d88ac9219b5b4f1570fd1702e546a80dba0832" "c27b3d858a9c033b93f9447337659d3ba34a72251b794e8bfe792ed722cc1f67" "bad832ac33fcbce342b4d69431e7393701f0823a3820f6030ccc361edd2a4be4" default)))
 '(safe-local-variable-values (quote ((org-adapt-indentation)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
