; groovy related customizations

(add-to-list 'auto-mode-alist '("\\.groovy\\'" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.gsp\\'" . nxml-mode))
(setq auto-mode-alist (cons '("\\.gradle$" . groovy-mode) auto-mode-alist))

(provide 'groovy)
