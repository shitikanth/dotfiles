(setq sk-org-packages '(org))

(defun sk-org/post-init-org ()
  (setq-default
   org-agenda-files
   '("~/.org/work.org"
     "~/.org/personal.org"
     "~/.org/research.org"
     "~/.org/notes.org")
   )

  (global-set-key (kbd "<f12>") 'org-agenda))
                 
