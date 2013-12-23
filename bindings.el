; key bindings

; use smex with M-x
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

; smart-beginning-of-line
(global-set-key (kbd "C-a") 'smart-beginning-of-line)

; org-mode
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)

; expand-region
(global-set-key "\M-@" 'er/expand-region)
(global-set-key "\M-#" 'er/contract-region)

; multiple-cursors
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-M->") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C-M-<") 'mc/skip-to-previous-like-this)

; programming
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

(provide 'bindings)
