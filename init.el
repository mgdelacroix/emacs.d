(require 'package)

(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))

(package-initialize)

(unless (require 'use-package nil :noerror)
  (package-install 'use-package)
  (require 'use-package))

(setq use-package-always-ensure t
      use-package-verbose t)

(use-package nyan-mode
  :init
  (nyan-mode))

(use-package beacon
  :init
  (beacon-mode 1))

(use-package expand-region
  :bind
  ("M-@" . er/expand-region)
  ("M-#" . er/contract-region))

(use-package multiple-cursors
  :bind
  ("M-p" . mc/mark-next-like-this)
  ("M-o" . mc/mark-previous-like-this)
  ("C-c C-o" . mc/mark-all-like-this)
  ("M-P" . mc/skip-to-next-like-this)
  ("M-O" . mc/skip-to-previous-like-this))

(use-package ido
  :init
  (ido-mode t))

(use-package ido-vertical-mode
  :init
  (ido-vertical-mode t))

(use-package git-gutter
  :init
  (global-git-gutter-mode +1))

(use-package smex
  :init
  (smex-initialize))

(use-package projectile
  :init
  (projectile-global-mode))

(use-package restclient)

(require 'cl)
(use-package groovy-mode
  :mode ("\\.groovy\\'" "\\.gsp\\'" "\\.gradle$"))

(use-package clojure-mode
  :mode ("\\.clj\\'" "\\.cljs\\'" "\\.boot\\'"))

(use-package markdown-mode
  :mode ("\\.md\\'" "\\.markdown\\'"))

(use-package magit
  :bind
  ("C-c m" . magit-status))

(use-package yaml-mode
  :mode ("\\.yml\\'" "\\.yaml\\'"))

;; self-functions require and config
;; smart-beginning-of-line
(defun mcrx/smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

     Move point to the first non-whitespace character on this line.
     If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
	 (beginning-of-line))))


;; swap-theme
(defun mcrx/swap-theme ()
  "Change between light and dark themes"
  (interactive)
  (cl-labels ((change-theme (new-theme old-theme)
                            (disable-theme old-theme)
                            (load-theme new-theme)
                            (setq *mcrx/current-theme* new-theme)))
    (if (eq *mcrx/current-theme* *mcrx/dark-theme*)
        (change-theme *mcrx/light-theme* *mcrx/dark-theme*)
      (change-theme *mcrx/dark-theme* *mcrx/light-theme*))))

(global-set-key (kbd "C-a") 'mcrx/smart-beginning-of-line)

(setq *mcrx/dark-theme* 'misterioso
      *mcrx/light-theme* 'leuven
      *mcrx/current-theme* *mcrx/dark-theme*)

(load-theme *mcrx/current-theme*)

(global-set-key (kbd "<f12>") 'mcrx/swap-theme)

;; MAIL
(autoload 'wl "wl" "Wanderlust" t)

;; Deactivate all toolbars and menus
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; fill-column
(setq fill-column 120)

;; Column number
(setq column-number-mode t)

;; Rayas en la franja izquierda cuando no hay más líneas en el buffer
(toggle-indicate-empty-lines)
(fringe-mode '(4 . 0))

;; We want to delete selected stuff when writting
(delete-selection-mode)

;; Limit words depending on camel-case
(global-subword-mode)

;; Basic indentation
(setq-default c-basic-offset 4)

;; Tabs configuration
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Deactivate splash screen
(setq inhibit-splash-screen t)

;; Font
(set-default-font "Fira Code")
(add-to-list 'default-frame-alist
	     '(font . "Fira Code-14"))

;; Auto revert buffers when they change
(global-auto-revert-mode)
(setq auto-revert-verbose nil)

;; Force case matching when using /dabbrev-expand/
(setq dabbrev-case-fold-search nil)

;; Delete trailing whitespace before saving a file
(setq delete-trailing-lines t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; auto-save configuration
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; backup configuration
(setq backup-directory-alist `(("." . "~/.saves")))

;; ** Emacs LISP customizations
;;
;;    Rainbow mode
;;    #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;      (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
;;    #+END_SRC
;;
;; ** Javascript customizations
;;
;;    #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;      (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;;      (add-to-list 'auto-mode-alist '("\\.es6\\'" . js2-mode))
;;
;;      (add-hook 'js2-mode-hook (progn
;;                                (setq js2-basic-offset 2
;;                                      js-indent-level 2
;;                                      js2-include-node-externs t)))
;;    #+END_SRC
;;
;;    Change tabs to 2 on json and javascript modes
;;    #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;      (add-hook 'javascript-mode-hook
;;                (lambda ()
;;                  (setq js-indent-level 2)))
;;
;;      (add-hook 'json-mode-hook
;;                (lambda ()
;;                  (setq tab-width 2)))
;;    #+END_SRC
;;
;; * ERC customizations
;;
;;   Remove ~join~, ~part~ and ~quit~ messages
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (setq erc-hide-list '("JOIN" "PART" "NICK" "MODE" "QUIT"))
;;   #+END_SRC
;;
;;   Add inline image support
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (require 'erc-image)
;;     (add-to-list 'erc-modules 'image)
;;     (erc-update-modules)
;;   #+END_SRC
;;
;;   Connect ~erc~ with libnotify
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (add-to-list 'erc-modules 'notifications)
;;   #+END_SRC
;;
;; * Org customizations
;;
;;   Todo keywords
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (setq org-todo-keywords '((sequence "TODO" "DONE")))
;;   #+END_SRC
;;
;;   Org directory
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (setq org-directory "~/org")
;;   #+END_SRC
;;
;;   Agenda customizations
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (load-library "find-lisp")
;;     (setq org-agenda-files (find-lisp-find-files org-directory "\.org$"))
;;   #+END_SRC
;;
;;   Associate org-mode with =.org= files
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;;   #+END_SRC
;;
;;   Activate auto-fill-mode in org files
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (add-hook 'org-mode-hook 'auto-fill-mode)
;;   #+END_SRC
;;
;;   Prettify
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (setq org-src-fontify-natively t)
;;     (setq org-html-inline-images t)
;;   #+END_SRC
;;
;;   Include diary
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (setq org-agenda-include-diary t)
;;   #+END_SRC
;;
;;   Remove holidays from diary
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (setq general-holidays nil)
;;     (setq diary-show-holidays-flag nil)
;;   #+END_SRC
;;
;; ** Diary
;;
;;    Set diary file
;;    #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;      (setq diary-file (concat org-directory "/diary"))
;;    #+END_SRC
;;
;; ** Org journal
;;
;;    Set journal dir
;;    #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;      (setq org-journal-dir (concat org-directory "/journal"))
;;    #+END_SRC
;;
;; ** Org mobile
;;
;;    Documentation [[http://orgmode.org/manual/MobileOrg.html][here]]
;;    #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;      (setq org-mobile-directory "~/Dropbox/MobileOrg")
;;    #+END_SRC
;;
;;    Files to be staged for MobileOrg
;;    #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;      (setq org-mobile-files org-agenda-files)
;;    #+END_SRC
;;
;;    Avoid creating id properties in the agenda files when pulling from
;;    MobileOrg[fn:1]
;;    #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;      (setq org-mobile-force-id-on-agenda-items nil)
;;    #+END_SRC
;;
;; ** Org capture
;;
;;    Where the notes will be saved ([[http://orgmode.org/manual/Capture.html][docs]])
;;    #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;      (setq org-default-notes-file (concat org-directory "/notes.org"))
;;    #+END_SRC
;;
;;    New templates
;;    #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;      (setq org-capture-templates
;;            '(("t" "Todo" entry (file+headline (concat org-directory "/gtd.org") "Tasks")
;;               "* TODO %?\n %i\n %a")
;;              ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
;;               "* %?\nEntered on %U\n %i\n %a")))
;;    #+END_SRC
;;
;; ** Org languages
;;
;;    Add org languages
;;    #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;      ;; active Org-babel languages
;;      (org-babel-do-load-languages
;;       'org-babel-load-languages
;;       '(;; other Babel languages
;;         (plantuml . t)
;;         (ditaa . t)))
;;    #+END_SRC
;;
;;    Point org jar paths
;;    #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;      (setq org-plantuml-jar-path
;;            (expand-file-name "~/opt/plantuml.jar"))
;;
;;      (setq org-ditaa-jar-path
;;            (expand-file-name "~/opt/ditaa.jar"))
;;    #+END_SRC
;;
;; * Slime customizations
;;
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;; ;    (require 'slime)
;;   #+END_SRC
;;
;;   Setting the REPL command
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (setq inferior-lisp-program "sbcl")
;;   #+END_SRC
;;
;; * Multi-term customizations
;;
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (setq multi-term-program "/usr/bin/zsh")
;;
;;     (setq term-bind-key-alist
;;           (list
;;            (cons "C-c C-j" 'term-line-mode)
;;            (cons "C-c C-k" 'term-char-mode)
;;            (cons "C-c C-c" 'term-interrupt-subjob)
;;            (cons "C-c C-z" 'term-stop-subjob)
;;            (cons "M-b" 'term-send-backward-word)))
;;   #+END_SRC
;;
;; * Custom functions
;;
;; ** smart-beginning-of-line
;;
;;    This function will be bound to =C-a=.
;;    #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;      ; smart-beginning-of-line
;;      (defun smart-beginning-of-line ()
;;        "Move point to first non-whitespace character or beginning-of-line.
;;
;;      Move point to the first non-whitespace character on this line.
;;      If point was already at that position, move point to beginning of line."
;;        (interactive)
;;        (let ((oldpos (point)))
;;          (back-to-indentation)
;;          (and (= oldpos (point))
;;               (beginning-of-line))))
;;    #+END_SRC
;;
;; ** insert-current-date
;;
;;    #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;      ; insert-current-date
;;      (defun insert-current-date ()
;;        "Inserts the current date in yyyy-mm-dd format"
;;        (interactive)
;;        (insert (shell-command-to-string "echo -n `date +%Y-%m-%d`")))
;;    #+END_SRC
;;
;; * Key bindings
;;
;;   avoid sending emacs to sleep with C-z.
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (global-unset-key (kbd "C-z"))
;;   #+END_SRC
;;
;;   If sleeping, emacs can be awekened with =SIGCONT=
;;   #+BEGIN_SRC shell-script
;;     killall -CONT emacs
;;     killall -CONT emacsclient
;;   #+END_SRC
;;
;;   use smex with M-x
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     ;(global-set-key (kbd "M-x") 'smex)
;;     ;(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;;   #+END_SRC
;;
;;   ibuffer with the default buffer list
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (global-set-key (kbd "C-x C-b") 'ibuffer)
;;   #+END_SRC
;;
;;   smart-beginning-of-line
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (global-set-key (kbd "C-a") 'smart-beginning-of-line)
;;   #+END_SRC
;;
;;   org-mode
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (global-set-key (kbd "C-c c") 'org-capture)
;;     (global-set-key (kbd "C-c a") 'org-agenda)
;;   #+END_SRC
;;
;;   expand-region
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (global-set-key "\M-@" 'er/expand-region)
;;     (global-set-key "\M-#" 'er/contract-region)
;;   #+END_SRC
;;
;;   multiple-cursors
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (global-set-key (kbd "M-p") 'mc/mark-next-like-this)
;;     (global-set-key (kbd "M-o") 'mc/mark-previous-like-this)
;;     (global-set-key (kbd "C-c C-o") 'mc/mark-all-like-this)
;;     (global-set-key (kbd "M-P") 'mc/skip-to-next-like-this)
;;     (global-set-key (kbd "M-O") 'mc/skip-to-previous-like-this)
;;   #+END_SRC
;;
;;   programming
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
;;   #+END_SRC
;;
;;   magit
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (global-set-key (kbd "C-c m") 'magit-status)
;;   #+END_SRC
;;
;;   ace-jump-mode
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (global-set-key (kbd "C-c SPC") 'ace-jump-mode)
;;   #+END_SRC
;;
;;   mu4e
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (global-set-key (kbd "C-c em") 'mu4e)
;;     (global-set-key (kbd "C-c eu") 'mu4e-update-mail-and-index)
;;   #+END_SRC
;;
;;   dired
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (define-key dired-mode-map (kbd "C-c C-e") 'wdired-change-to-wdired-mode)
;;   #+END_SRC
;;
;; ** Chords
;;
;;    First we need to activate =key-chord-mode=
;;    #+BEGIN_SRC emacs-lisp
;;      (require 'key-chord)
;;      (key-chord-mode 1)
;;    #+END_SRC
;;
;;    Then we can define as many chords as we want:
;;
;;    *window resize*
;;    #+BEGIN_SRC emacs-lisp
;;      (key-chord-define-global "rh" 'shrink-window-horizontally)
;;      (key-chord-define-global "rl" 'enlarge-window-horizontally)
;;      (key-chord-define-global "rj" 'shrink-window)
;;      (key-chord-define-global "rk" 'enlarge-window)
;;    #+END_SRC
;;
;; * Personal webpage
;;
;;   #+BEGIN_SRC emacs-lisp :tangle ~/.emacs.d/init.el
;;     (setq org-publish-project-alist
;;           '(
;;             ("personal-webpage-notes"
;;              :base-directory "~/org/personal-webpage"
;;              :base-extension "org"
;;              :publishing-directory "~/org/personal-webpage_public"
;;              :recursive t
;;              :publishing-function org-html-publish-to-html
;;              :headline-levels 4
;;              :auto-preamble t)
;;             ("personal-webpage-static"
;;              :base-directory "~/org/personal-webpage"
;;              :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg"
;;              :publishing-directory "~/org/personal-webpage_public"
;;              :recursive t
;;              :publishing-function org-publish-attachment)
;;             ("personal-webpage" :components ("personal-webpage-notes" "personal-webpage-static"))
;;             ))
;;   #+END_SRC
;;
;; * Footnotes
;;
;; [fn:1] [[http://orgmode.org/manual/Pushing-to-MobileOrg.html#fnd-2][Docs here]]
