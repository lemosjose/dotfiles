;; remove the toolbar (that i personally don't like)
(tool-bar-mode -1)


;;numbers
(global-display-line-numbers-mode 1)
(global-tab-line-mode t)

;;packages
(require 'package)
(setq package-enable-at-startup nil)
;;MELPA
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))

(package-initialize)

;;disables the splash screen :^) 
(setq inhibit-splash-screen t)
	 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("~/Org-Notes/agenda.org"))
 '(package-selected-packages
   '(auto-dark treemacs-all-the-icons treemacs-tab-bar linum-relative yasnippet dir-treeview flycheck cider company helm-lsp lsp-ui auto-complete org-modern lsp-mode helm pdf-tools magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;draculafying my emacs
(require 'auto-dark)
(auto-dark-mode t)

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

(require 'yanisppet)
(yas-global-mode 1)
(require 'flex-autopair)
(ac-config-default)
(flycheck-global-mode 1)

;;lsp stuff
(setq lsp-keymap-prefix "s-l")
(require 'lsp-mode)


(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)



(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'c++-mode-hook 'lsp)
(add-to-list 'auto-mode-alist '("\\.cpp$". c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp$". c++-mode))


(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1) ;;clangd is fast (from https://emacs-lsp.github.io/lsp-mode/tutorials/CPP-guide/)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

(add-hook 'clojure-mode-hook 'lsp)

(add-hook 'cider-mode-hook #'company-mode)
(global-set-key (kbd "TAB") #'company-indent-or-complete-common)
(define-key global-map (kbd "RET") 'newline-and-indent)

;; org-mode configs
(transient-mark-mode 1)

(require 'org)
(global-set-key "\C-ca" 'org-agenda)


(setq org-default-notes-file "~/Org-Notes/init.org"
      initial-buffer-choice org-default-notes-file)

(use-package treemacs
  :ensure t)

(global-set-key "\C-cf" 'treemacs)

(treemacs)
