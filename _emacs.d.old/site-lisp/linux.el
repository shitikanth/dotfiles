;;; linux.el ---
;;; Settings to use only when I am on linux

(defun system-specific-setup()
  ; Default font
  (set-default-font "Noto Mono-11")
  (add-to-list 'default-frame-alist (cons 'width 120))
  ; Not much else
)
