(add-to-list 'load-path "~/.emacs.d/auto-dark/")
(require 'auto-dark)

;; remove the toolbar (that i personally don't like)
(tool-bar-mode -1)


;;draculafy things
(auto-dark-mode t)


;;packages
(require 'package)
(setq package-enable-at-startup nil)

;;MELPA

(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/") t)


(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-content)
  (package-install 'use-package))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(lsp-mode helm pdf-tools magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



