
;;
;;
;; Org-mode settings
;;
;;
;;
;;

(provide 'org-settings)

(require 'org)
(require 'org-install)


(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;(message "orgsettings: set agenda files")
(setq org-agenda-files
      (list "~/.org/work.org"
            "~/.org/research.org"
            "~/.org/personal.org"
;            "~/.org/hobbies.org"
            "~/.org/notes.org" ))

(setq org-default-notes-file "~/.org/notes.org")


; http://www.andrew.cmu.edu/user/cgliu/howto.html
(setq org-publish-project-alist
      '(("www"
         :components ("www-org" "www-static"))
        ("www-org"
         :base-directory "~/www/org-src/"
         :base-extension "org"
         :publishing-directory "~/www"
         :recursive t
         :publishing-function org-html-publish-to-html
         :section-numbers nil
         :with-toc nil
         :htmlized-source t
         :auto-sitemap t
         :html-preamble "<div id=\"header\" class=\"container\">
  <h1 class=\"banner\"> Shitikanth Kashyap </h1>
  <hr class=\"thin\">
  <div class=\"navbar navbar-invert\" role=\"navigation\">
  <ul id=\"menu\" class=\"nav navbar-nav navbar-center\">
    <li><a href=\"/\">About me</a></li>
    <li><a href=\"/research.html\">Research</a></li>
    <li><a href=\"/blog/\">Blog</a></li>
  </ul>
  </div>
</div>"
         :html-postamble nil)
        ("www-static"
         :base-directory "~/www/org-src/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|otf"
         :publishing-directory "~/www"
         :recursive t
         :publishing-function org-publish-attachment)))

(setq org-html-htmlize-output-type 'css)
(setq org-file-apps
      '((auto-mode . emacs)
	("\\.mm\\'" . default)
	("\\.x?html?\\'" . default)
	("\\.pdf\\'" . "/Applications/Skim.app/Contents/MacOS/Skim %s")))

;(MESSAGE "orgsettings: set todo keywords")
(setq org-todo-keywords
  '((sequence "TODO(t!)" "STARTED(z!)" "NEXT(n!)" "|" "DONE(d!/!)")
    (sequence "WAITING(w@/!)" "MAYBE(m!)" "SOMEDAY(s!)" "|" "CANCELLED(c@/!)")
    ;(sequence "QUOTE(q!)" "QUOTED(Q!)" "|" "APPROVED(A@)" "EXPIRED(E@)" "REJECTED(R@)")
    (sequence "OPEN(O!)" "|" "CLOSED(C!)")))

(setq org-use-fast-todo-selection t)

(setq org-todo-keyword-faces
      (quote (("TODO"      :foreground "#9f3f3a"      :weight bold)
              ("STARTED"   :foreground "orange"       :weight bold)
              ("NEXT"      :foreground "#ff7092"      :weight bold)
              ("DONE"      :foreground "#758837"      :weight bold)
              ("WAITING"   :foreground "#a8799c"      :weight bold)
              ("MAYBE"     :foreground "goldenrod"    :weight bold)
              ("SOMEDAY"   :foreground "goldenrod"    :weight bold)
              ("CANCELLED" :foreground "orangered"    :weight bold)
              ;("QUOTE"     :foreground "hotpink"      :weight bold)
              ;("QUOTED"    :foreground "indianred1"   :weight bold)
              ;("APPROVED"  :foreground "forest green" :weight bold)
              ;("EXPIRED"   :foreground "olivedrab1"   :weight bold)
              ;("REJECTED"  :foreground "olivedrab"    :weight bold)
              ("OPEN"      :foreground "#ffffcc"      :weight bold)
              ("CLOSED"    :foreground "#758837"      :weight bold))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Tags
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-tags-column -75)
(setq org-tag-alist
      '((:startgroup)
        ("@personal" . ?0)
        ("@college" . ?1)
        ("@office" . ?2)
        ("@social" . ?3)
        ("@research" . ?4)
        ("@home" . ?5)
        ("@shopping" . ?6)
        (:endgroup)
        ("PROJECT" . ?p)
        ("IMPORTANT". ?i)
        ("URGENT" . ?u)
        ("HABIT" . ?h)
        ("NOTE" . ?n)
        ))

(setq org-tag-faces
      '(("@personal" :foreground "#90a0a0")
        ("@college" :foreground "dark green")
        ("@office" :foreground "#0084c8")
        ("@social" :foreground "#caccb7")
        ("@home" :foreground "#90a0a0")
        ("@shopping" :foreground "#90a0a0")
        ("@research" :foreground "#00578e")
        ("IMPORTANT" :foreground "red" :weight bold)
        ))

;; Enable Habits
(add-to-list 'org-modules 'org-habit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Org-mode contrib
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'org-checklist)

;; Google calendar sync
;; -- not mature, don't use

;; (require 'org-caldav)
;; (setq org-caldav-calendar-id "ebn6n7m2g4vublgnr3jbbmj1kc@group.calendar.google.com")
;; (setq org-caldav-inbox "~/.org/notes.org")
;; (setq org-caldav-files
;;       '("~/.org/work.org"
;;         "~/.org/college.org"
;;         "~/.org/personal.org"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Agenda tweaks
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-agenda-include-diary t)
(setq org-log-done t)

;(setq org-agenda-show-all-dates t)
;(setq org-agenda-sorting-strategy
;      '((agenda habit-down time-up priority-down effort-up category-keep)
;              (todo priority-down)
;              (tags priority-down)))

(setq org-agenda-time-grid
      '((daily require-timed)
        "--------------------"
        (800 1000 1200 1400 1600 1800 2000 2200)))

(setq org-agenda-custom-commands
      '(("w" "Weekly Review"
         ((agenda "" ((org-agenda-ndays 7))) ;; review upcoming appointments
          (agenda "" ((org-agenda-time-grid nil)
                      (org-deadline-warning-days 31)
                      (org-agenda-entry-types '(:deadline))))
          ))

))

(setq org-stuck-projects
      '("+PROJECT/-MAYBE-DONE" ("NEXT" "TODO") nil ""))

;; Match tags and show content
(defun org-tag-match-context (&optional todo-only match)
  "Identical search to `org-match-sparse-tree', but shows the content of the matches."
  (interactive "P")
  (org-prepare-agenda-buffers (list (current-buffer)))
  (org-overview)
  (org-remove-occur-highlights)
  (org-scan-tags '(progn (org-show-entry)
                         (org-show-context))
                 (cdr (org-make-tags-matcher match)) todo-only))

(global-set-key (kbd "<f9> m") 'org-tag-match-context)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Latex export settings
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(require 'org-latex)
;(message "loading org-mode latex settings")

(setq org-latex-pdf-process (list "latexmk -pdf -outdir=%o %b"))
(setq org-latex-with-hyperref nil)

(setq org-latex-packages-alist
      '(("AUTO" "inputenc" t)
        ("T1" "fontenc" t)
        ("" "fixltx2e" t)
        ("" "graphicx" t)
        "\\tolerance=1000"))

(setq org-latex-classes
'(("article" "\\documentclass[11pt]{article}"
  ("\\section{%s}" . "\\section*{%s}")
  ("\\subsection{%s}" . "\\subsection*{%s}")
  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
  ("\\paragraph{%s}" . "\\paragraph*{%s}")
  ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
 ("report" "\\documentclass[11pt]{report}"
  ("\\part{%s}" . "\\part*{%s}")
  ("\\chapter{%s}" . "\\chapter*{%s}")
  ("\\section{%s}" . "\\section*{%s}")
  ("\\subsection{%s}" . "\\subsection*{%s}")
  ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
 ("book" "\\documentclass[11pt]{book}"
  ("\\part{%s}" . "\\part*{%s}")
  ("\\chapter{%s}" . "\\chapter*{%s}")
  ("\\section{%s}" . "\\section*{%s}")
  ("\\subsection{%s}" . "\\subsection*{%s}")
  ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

(add-to-list
 'org-latex-classes
 '("org-article"
   "\\documentclass{article}
[NO-DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]

\\setlength{\\topmargin}{0in}
\\setlength{\\headheight}{0in}
\\setlength{\\headsep}{0in}
\\setlength{\\textheight}{8.9in}
\\setlength{\\oddsidemargin}{0in}
\\setlength{\\textwidth}{6.5in}"

    ("\\section{%s}" . "\\section*{%s}")
    ("\\subsection{%s}" . "\\subsection*{%s}")
    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
    ("\\paragraph{%s}" . "\\paragraph*{%s}")
    ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list
 'org-latex-classes
 '("org-math"
   "\\documentclass[11pt]{article}
[NO-DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]
\\usepackage{amsmath,amsthm,amsfonts,amssymb,mathtools}
\\usepackage[sc]{mathpazo}
\\usepackage[pass]{geometry}

\\setlength{\\topmargin}{0in}
\\setlength{\\headheight}{0in}
\\setlength{\\headsep}{0in}
\\setlength{\\textheight}{8.9in}
\\setlength{\\oddsidemargin}{0in}
\\setlength{\\textwidth}{6.5in}

\\newtheorem{theorem}{Theorem}
\\newtheorem{lemma}[theorem]{Lemma}
\\newtheorem{prop}[theorem]{Proposition}
\\newtheorem{cor}[theorem]{Corollary}
\\theoremstyle{definition}
\\newtheorem{definition}[theorem]{Definition}
\\newtheorem{claim}[theorem]{Claim}
\\newtheorem{remark}[theorem]{Remark}
"
    ("\\section{%s}" . "\\section*{%s}")
    ("\\subsection{%s}" . "\\subsection*{%s}")
    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
    ("\\paragraph{%s}" . "\\paragraph*{%s}")
    ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(setq org-latex-default-class "org-math")

;; @TODO This is broken in new org-mode
;; Custom export blocks
; (setq org-export-blocks
;  (cons '(latexmacro org-export-blocks-latexmacro) org-export-blocks))

(defun org-export-blocks-latexmacro (body &rest headers)
  (message "exporting latex macros")
  (cond
   ((eq org-export-current-backend 'html) (concat "\\(" body "\\)"))
   ((eq org-export-current-backend 'latex) (concat "#+BEGIN_LATEX\n" body "#+END_LATEX\n"))
   (t nil))
)

(setq org-export-publishing-directory "./exports")
;(print org-export-publishing-directory)

(setq reftex-default-bibliography
      (quote
       ("~/refs.bib" "other-default.bib")))
(setq-default TeX-master t)

(defun org-mode-reftex-setup ()
  (interactive)
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation))
(add-hook 'org-mode-hook 'org-mode-reftex-setup)


(setq org-hide-block-startup "hideblocks")


;;
;; Settings for clocks


;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Change task to STARTED when clocking in
(setq org-clock-in-switch-to-state 'bh/clock-in-to-started)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist (quote history))
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)


(setq bh/keep-clock-running nil)

(defun bh/clock-in-to-started (kw)
  "Switch task from TODO or NEXT to STARTED when clocking in.
Skips capture tasks."
  (if (and (member (org-get-todo-state) (list "TODO" "NEXT"))
           (not (and (boundp 'org-capture-mode) org-capture-mode)))
      "STARTED"))

(defun bh/find-project-task ()
  "Move point to the parent (project) task if any"
  (let ((parent-task (save-excursion (org-back-to-heading) (point))))
    (while (org-up-heading-safe)
      (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
        (setq parent-task (point))))
    (goto-char parent-task)
    parent-task))

(defun bh/clock-in-and-set-project-as-default (pom)
  "Clock in the current task and set the parent project (if any) as the
default clocking task.  Agenda filter tags are set from the default task"
  ;; Find the parent project task if any and set that as the default
  (save-excursion
    (save-excursion
      (org-with-point-at pom
        (bh/find-project-task)
        (org-clock-in '(16))))
    (save-excursion
      (org-with-point-at pom
        (org-clock-in nil)))))

(defun bh/set-agenda-restriction-lock ()
  "Set filter to tags of POM, current task, or current project and refresh"
  (interactive)
  ;;
  ;; We're in the agenda
  ;;
  (let* ((pom (org-get-at-bol 'org-hd-marker))
         (tags (org-with-point-at pom (org-get-tags-at))))
    (if (equal major-mode 'org-agenda-mode)
        (if tags
            (org-with-point-at pom
              (bh/find-project-task)
              (org-agenda-set-restriction-lock))
          (org-agenda-remove-restriction-lock))
      (if (equal org-clock-default-task (org-id-find "eb155a82-92b2-4f25-a3c6-0304591af2f9" 'marker))
          (org-agenda-remove-restriction-lock)
        (org-with-point-at pom
          (bh/find-project-task)
          (org-agenda-set-restriction-lock))))))

(defun bh/punch-in ()
  "Start continuous clocking and set the default task to the project task
of the selected task.  If no task is selected set the Organization task as
the default task."
  (interactive)
  (setq bh/keep-clock-running t)
  (if (equal major-mode 'org-agenda-mode)
      ;;
      ;; We're in the agenda
      ;;
      (let* ((marker (org-get-at-bol 'org-hd-marker))
             (tags (org-with-point-at marker (org-get-tags-at))))
        (if tags
            (bh/clock-in-and-set-project-as-default marker)
          (bh/clock-in-organization-task-as-default)))
    ;;
    ;; We are not in the agenda
    ;;
    (save-restriction
      (widen)
      ; Find the tags on the current task
      (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)))
          (bh/clock-in-and-set-project-as-default nil)
        (bh/clock-in-organization-task-as-default))))
  (bh/set-agenda-restriction-lock))

(defun bh/punch-out ()
  (interactive)
  (setq bh/keep-clock-running nil)
  (when (org-clock-is-active)
    (org-clock-out))
  (org-agenda-remove-restriction-lock))

(defun bh/clock-in-default-task ()
  (save-excursion
    (org-with-point-at org-clock-default-task
      (org-clock-in))))

(defun bh/clock-in-organization-task-as-default ()
  (interactive)
  (save-restriction
    (widen)
    (org-with-point-at (org-id-find "eb155a82-92b2-4f25-a3c6-0304591af2f9" 'marker)
      (org-clock-in '(16)))))

(defun bh/clock-out-maybe ()
  (when (and bh/keep-clock-running
             (not org-clock-clocking-in)
             (marker-buffer org-clock-default-task)
             (not org-clock-resolving-clocks-due-to-idleness))
    (bh/clock-in-default-task)))

(add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)

(global-set-key (kbd "<f9> t") 'bh/insert-inactive-timestamp)
(global-set-key (kbd "<f9> SPC") 'bh/clock-in-last-task)
(global-set-key (kbd "C-<f9>") 'previous-buffer)
(global-set-key (kbd "C-x r") 'narrow-to-region)
(global-set-key (kbd "C-<f10>") 'next-buffer)
(global-set-key (kbd "<f11>") 'org-clock-goto)
(global-set-key (kbd "C-<f11>") 'org-clock-in)
(global-set-key (kbd "C-s-<f12>") 'bh/save-then-publish)
(global-set-key (kbd "M-<f11>") 'org-resolve-clocks)
(global-set-key (kbd "C-M-r") 'org-capture)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c C-r") 'org-update-statistics-cookies)


;; Custom Key Bindings
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "<f5>") 'bh/org-todo)
(global-set-key (kbd "<f6>") 'bh/widen)
(global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
(global-set-key (kbd "<f9> c") 'calendar)
(global-set-key (kbd "<f9> f") 'boxquote-insert-file)
(global-set-key (kbd "<f9> g") 'gnus)
(global-set-key (kbd "<f9> h") 'bh/hide-other)

(defun bh/org-todo ()
  (interactive)
  (widen)
  (org-narrow-to-subtree)
  (org-show-todo-tree nil))

(defun bh/widen ()
  (interactive)
  (widen)
  (org-reveal))

(defun bh/hide-other ()
  (interactive)
  (save-excursion
    (org-back-to-heading)
    (org-shifttab)
    (org-reveal)
    (org-cycle)))

(global-set-key (kbd "<f9> i") 'bh/punch-in)
(global-set-key (kbd "<f9> o") 'bh/punch-out)

;(message "No errors till here")


;(global-set-key (kbd "M-<f9>") (lambda ()
;                                 (interactive)
;                                 (unless (buffer-modified-p)
;                                   (kill-buffer (current-buffer)))
;                                 (delete-frame)))


(setq org-treat-S-cursor-todo-selection-as-state-change nil)
