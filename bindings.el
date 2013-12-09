; key bindings

; use smex with M-x
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

; smart-beginning-of-line
(global-set-key (kbd "C-a") 'smart-beginning-of-line)

; org-mode
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)

(provide 'bindings)
