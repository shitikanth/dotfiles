
; Load system-specific library and setup system-specific things that 
; must be setup before main setup 
(cond ((eq system-type 'windows-nt) (load-library "nt"))
      ((eq system-type 'darwin) (load-library "osx"))
      ((eq system-type 'gnu/linux) (load-library "linux"))
      (t (load-library "default")))

(system-specific-setup)

(provide 'system)
