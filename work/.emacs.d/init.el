(global-display-line-numbers-mode t)


(require 'package)
(setq package-enable-at-startup nil)


(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)


(setq inhibit-splash-screen t)


(require 'flex-autopair)

(use-package srcery-theme
  :ensure t
  :config
  (load-theme 'srcery t))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(web-mode auto-complete yasnippet-snippets java-snippets company flycheck-eglot tide tagedit pdf-tools org-bullets eglot-java typescript-mode emmet-mode lsp-java python-mode lsp-ui lsp-mode vue-mode powerline treemacs srcery-theme flex-autopair)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (python-mode . pyright)
         ;; if you want which-key integration         
  :commands lsp))

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)

;; setup auto-complete
(ac-config-default)


;;setup vuejs development hooks
(add-to-list 'auto-mode-alist '("\\.vue$". web-mode))
(add-to-list 'auto-mode-alist '("\\.vue$". css-mode))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

;; if you use typescript-mode
(add-hook 'typescript-mode-hook #'setup-tide-mode)
;; if you use treesitter based typescript-ts-mode (emacs 29+)
(add-hook 'typescript-ts-mode-hook #'setup-tide-mode)

(require 'powerline)
(powerline-default-theme)
(treemacs)


