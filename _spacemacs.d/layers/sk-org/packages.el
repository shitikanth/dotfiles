(setq sk-org-packages '(org))

(defun sk-org/post-init-org ()
  (setq-default
   org-agenda-files
   '("~/.org/work.org"
     "~/.org/personal.org"
     "~/.org/research.org"
     "~/.org/notes.org")
    org-default-notes-file
    "~/.org/notes.org"
   )

  (setq org-todo-keywords
        '((sequence "TODO(t!)" "STARTED(z!)" "NEXT(n!)" "|" "DONE(d!/!)")
          (sequence "WAITING(w@/!)" "MAYBE(m!)" "SOMEDAY(s!)" "|" "CANCELLED(c@/!)")
          (sequence "OPEN(O!)" "|" "CLOSED(C!)")))

  (setq org-use-fast-todo-selection t)
  (setq org-bullets-bullet-list
        '("◉" "✸" "►" "○" "◇" "✿"))

  ;; globally turn on org-indent-mode for all files
  (setq org-startup-indented t)

  (global-set-key (kbd "<f12>") 'org-agenda)

  )
