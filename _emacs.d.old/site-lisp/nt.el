;; nt.el
;; Settings to use only when I am on windows

(defun system-specific-setup()
 
;; AUCTEX customization

 (setq TeX-view-program-list (quote (("sumatra" "SumatraPdf.exe %o"))))
 (setq TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and start") (output-dvi "Yap") (output-pdf "sumatra") (output-html "start"))))
 

;; Org mode viewer

(eval-after-load "org"
  '(progn
     ;; Change .pdf association directly within the alist
     (setcdr (assoc "\\.pdf\\'" org-file-apps) "SumatraPdf.exe %s")))

;; Org mode latex command
(setq org-latex-to-pdf-process (list "latexmk -c &  latexmk -f -pdf %f"))

;; ASPELL for windows

 (setq ispell-program-name "aspell")
; (setq ispell-personal-dictionary "E:\\programs\\Aspell\\dict\\english.alias")
 (require 'ispell) 

 (print "Loaded settings for nt")
;; Shortcuts for common directories

)
