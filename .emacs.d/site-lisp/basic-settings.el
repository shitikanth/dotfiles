;;; basic-settings.el --- My basic customizations and settings

(setq make-backup-files nil) ; stop creating ~ files
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(setq auto-save-list-file-prefix autosave-dir)

(provide 'basic-settings)
;;; basic-settings.el ends here
