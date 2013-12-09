(add-to-list 'load-path user-emacs-directory)

(require 'cask "~/.cask/cask.el")
(cask-initialize)

(require 'customizations)
(require 'tabs)
(require 'programming)
(require 'org-customization)
(require 'agenda-customization)
