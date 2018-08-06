(setq sk-org-packages
      '((ob-ipython :location local)
        org
        ox-reveal))


(defun sk-org/post-init-org ()
  (setq-default
   org-agenda-files '("~/.org/work.org"
                      "~/.org/personal.org"
                      "~/.org/research.org"
                      "~/.org/inbox.org")
   org-default-notes-file "~/.org/inbox.org"
   org-occur-case-fold-search 'smart
   org-highlight-sparse-tree-matches nil
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
  (global-set-key (kbd "C-'") 'org-cycle-agenda-files)
  (spacemacs/set-leader-keys
    "aof" 'org-cycle-agenda-files
    "aoi" 'sk-org/inbox)

  ;; enable man links
  (with-eval-after-load 'org
    (require 'org-man))


  ;; dont prompt me to confirm everytime I want to evaluate a block
  (setq org-confirm-babel-evaluate nil)
  )

(defun sk-org/post-init-ox-reveal ()
  (setq-default
   org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/"
   org-reveal-mathjax t
   org-reveal-title-slide "<h1>%t</h1><small><p>Created by %a</p></small>"))


(defun sk-org/init-ob-ipython ()
  (use-package ob-ipython
    :after org
    :config
    (progn
      (push '(ipython . t) org-babel-load-languages)
      (setq ob-ipython-output-exec-count nil))))
