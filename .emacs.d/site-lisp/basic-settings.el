;;; basic-settings.el --- My basic customizations and settings

;; Copyright (C) 2014  Shitikanth Kashyap

;; Author: Shitikanth Kashyap <shitikanth1@gmail.com>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(setq make-backup-files nil) ; stop creating ~ files


;;
;; Use package manager 
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa")
(add-to-list 'package-archives 
    '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives 
    '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(provide 'basic-settings)
;;; basic-settings.el ends here
