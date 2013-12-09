; org-agenda customizations

(load-library "find-lisp")
(setq org-agenda-files (find-lisp-find-files "~/org" "\.org$"))

(provide 'agenda-customization)
