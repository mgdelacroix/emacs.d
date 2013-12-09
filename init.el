(add-to-list 'load-path user-emacs-directory)

(require 'cask "~/.cask/cask.el")
(cask-initialize)

(require 'customizations)
