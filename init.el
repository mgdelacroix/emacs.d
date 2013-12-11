(add-to-list 'load-path user-emacs-directory)

(require 'cask "~/.cask/cask.el")
(cask-initialize)

(require 'customizations)
(require 'tabs)
(require 'programming)
(require 'agenda-customization)
(require 'bindings)
(require 'auto-save-files)
(require 'backup-files)
