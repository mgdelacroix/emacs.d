; programming related customizations

(require 'expand-region)
(require 'multiple-cursors)
(require 'ido-mode)
(require 'ido-ubiquitous)
(require 'smex)
(smex-initialize)
(ido-vertical-mode)
(projectile-global-mode)

(require 'groovy)
(require 'smart-beginning-of-line)

(global-git-gutter-mode +1)

(provide 'programming)
