(provide 'keybindings)

(global-set-key (kbd "C-z") 'switch-to-buffer)
(global-set-key (kbd "C-x C-z") 'suspend-frame)
(global-set-key (kbd "C-x b") 'counsel-bookmark)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq hs-minor-mode-map
      (let ((map (make-sparse-keymap)))
	(define-key map (kbd "C-c h C-h")	'hs-hide-block)
	(define-key map (kbd "C-c h C-s")	'hs-show-block)
	(define-key map (kbd "C-c h C-M-h")     'hs-hide-all)
	(define-key map (kbd "C-c h C-M-s")     'hs-show-all)
	(define-key map (kbd "C-c h C-l")	'hs-hide-level)
	(define-key map (kbd "C-c h C-c")	'hs-toggle-hiding)
	(define-key map (kbd "C-c h C-a")       'hs-show-all)
	(define-key map (kbd "C-c h C-t")       'hs-hide-all)
	(define-key map (kbd "C-c h C-d")       'hs-hide-block)
	(define-key map (kbd "C-c h C-e")       'hs-toggle-hiding)
	(define-key map [(shift mouse-2)]	'hs-mouse-toggle-hiding)
	map
	))
