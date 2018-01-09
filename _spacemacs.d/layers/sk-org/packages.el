(setq sk-org-packages
      '(org
        ox-reveal))


(defun sk-org/post-init-org ()
  (setq-default
   org-agenda-files '("~/.org/work.org"
                      "~/.org/personal.org"
                      "~/.org/research.org"
                      "~/.org/notes.org")
   org-default-notes-file "~/.org/notes.org"
   org-occur-case-fold-search 'smart
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

(defun sk-org/post-init-ox-reveal ()
  (setq-default
   org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/"
   org-reveal-mathjax t
   org-reveal-title-slide "<h1>%t</h1><small><p>Created by %a</p></small>"))
