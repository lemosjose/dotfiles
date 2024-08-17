;;; remove the toolbar (that i personally don't like)
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




(setq warning-minimum-level :error)

(use-package srcery-theme
  :ensure t
  :config
  (load-theme 'srcery t))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("652f922b5c4fab704da86af3702cb9225005bcb18b8d0545cf9245b115798780" default))
 '(org-agenda-files '("~/Org-Notes/agenda.org"))
 '(package-selected-packages
   '(adoc-mode typescript-mode multiple-cursors tide auto-package-update vue-mode scss-mode web-mode qml-mode lua-mode helm-slime ac-slime slime org-bullets yeetube treemacs-all-the-icons treemacs-tab-bar linum-relative yasnippet dir-treeview flycheck cider company helm-lsp lsp-ui auto-complete org-modern lsp-mode helm pdf-tools magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))


(require 'flex-autopair)
(ac-config-default)

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

(add-to-list 'auto-mode-alist (cons "\\.adoc\\'" 'adoc-mode))


(add-hook 'lua-mode-hook' 'lsp)
(add-to-list 'auto-mode-alist '(".lua". lua-mode))

(add-hook 'qml-mode-hook' 'lsp)
(add-to-list 'auto-mode-alist '(".qml". qml-mode))

(setq gc-cons-threshold (* 100 1024 1024)
      read/-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1) ;;clangd is fast (from https://emacs-lsp.github.io/lsp-mode/tutorials/CPP-guide/)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

(add-hook 'clojure-mode-hook 'lsp)

(setq sgml-tag 'close)
(add-to-list 'auto-mode-alist '("\\.vue". web-mode))
(setq web-mode-tag-auto-close-style 1)


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


(setq package-list '(dap-mode typescript-mode))
;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

;; if you use typescript-mode
(add-hook 'typescript-mode-hook #'setup-tide-mode)
;; if you use treesitter based typescript-ts-mode (emacs 29+)
(add-hook 'typescript-ts-mode-hook #'setup-tide-mode)


;;Common lisp stuff 
(require 'slime)
(slime-setup '(slime-fancy slime-quicklisp slime-asdf slime-mrepl))


(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")

(add-hook 'cider-mode-hook #'company-mode)
(global-set-key (kbd "TAB") #'company-indent-or-complete-common)
;;(define-key global-map (kbd "RET") 'newline-and-indent)

;; org-mode configs
(transient-mark-mode 1)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;;

(global-flycheck-mode)

(require 'org)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-ct" 'sgml-close-tag)


(setq org-default-notes-file "~/Org-Notes/init.org"
      initial-buffer-choice org-default-notes-file)

(use-package treemacs
  :ensure t)

(global-set-key "\C-cf" 'treemacs)


(setq org-agenda-files (list  "~/Org-Notes/estudos.org"
			      "~/Org-Notes/trabalho.org"
			      "~/Org-Notes/uemg.org"))


(require 'powerline)
(powerline-default-theme)

(treemacs)
(pdf-tools-install)
