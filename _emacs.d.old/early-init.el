;;; early-init.el --- Early init  -*- lexical-binding: t; -*-

(when (eq system-type 'darwin)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)))
