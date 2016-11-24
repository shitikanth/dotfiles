;;; linux.el --- 
;;; Settings to use only when I am on linux

(defun system-specific-setup()
  ; Default font
  (set-default-font "Monospace-10")
  (add-to-list 'default-frame-alist (cons 'width 120))
  ; Not much else
)
