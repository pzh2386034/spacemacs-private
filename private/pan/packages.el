;;; packages.el --- pan layer packages file for Spacemacs.
(provide 'init-keymaps)

;;; ==========================global key band=====================================
(global-set-key (kbd "C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-\\") 'highlight-symbol-at-point)
;;(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "M-j") 'other-window)
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-W") 'split-window-below-and-focus)
(global-set-key (kbd "M-w") 'split-window-right-and-focus)
;;(global-set-key (kbd "M-m") 'ido-imenu)
(global-set-key (kbd "M-q") 'quit-window)
(global-set-key (kbd "M-.") 'etags-select-find-tag)
(global-set-key (kbd "M-o") 'occur)
(global-set-key (kbd "<f3>") 'flycheck-list-errors)
(global-set-key (kbd "M-v") 'evil-paste-after)
(global-set-key (kbd "M-n") 'next-error)
;;(global-set-key (kbd "M-P") 'session-jump-to-last-change)
(global-set-key (kbd "M-p") 'previous-error)
(global-set-key (kbd "M-j") 'evil-window-next)
(global-set-key (kbd "M-t") 'projectile-find-file-other-window)
(global-set-key (kbd "C-p") 'switch-to-lOCAL-project)
(global-set-key (kbd "M-`") 'other-frame)
(global-set-key (kbd "C-c t") 'terminal)
(global-set-key (kbd "C-c T") 'named-term)
(setq auto-save-default nil)
(setq make-backup-files nil)
(spacemacs/set-leader-keys (kbd "dw") 'delete-other-windows)
(global-set-key (kbd "C-d") 'delete-forward-char)
(global-set-key (kbd "M-a") 'beginning-of-line)
(global-set-key (kbd "M-e") 'end-of-line)
;; space h space 搜索package help文档

;;(Define-key evil-insert-state-map (kbd "C-c C-t") 'ansi-term)
;; paste and copy system clipboard
(global-set-key (kbd "C-c y") 'clipboard-yank)
(global-set-key (kbd "C-c s") 'clipboard-kill-ring-save)
(global-set-key (kbd "C-c r") 'clipboard-kill-region)

(spacemacs/set-leader-keys "ou" 'my-auto-update-tags-when-save)
;; auto truncate lines
(setq-default toggle-truncate-line t)
(add-hook 'LaTeX-mode-hook 
          (lambda()
            (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
            (setq TeX-command-default "XeLaTeX")
            (setq TeX-save-query nil)
            (setq TeX-show-compilation t)))

(add-to-list 'load-path "~/.spacemacs.d/private/pan")
(require 'clean-aindent-mode)

(defun pan/load-yasnippet ()
  (interactive)
  (unless yas-global-mode
    (progn
      (yas-global-mode 1)
      (setq my-snippet-dir (expand-file-name "~/.spacemacs.d/private/snippets"))
      (setq yas-snippet-dirs  my-snippet-dir)
      (yas-load-directory my-snippet-dir)
      (setq yas-wrap-around-region t)))
  (yas-minor-mode 1))
(defconst pan-packages
  '(
    fcitx
    youdao-dictionary
    elpy
    yasnippet
    ;; ob-ipython
    ;; company
    ;; (company-c-headers :location (recipe :fetcher github :repo "randomphrase/company-c-headers"))
    yasnippet
    ;; auto-yasnippet
    yasnippet-snippets  ;; common snippets
    markdown-mode
    lispy
    )
  )
(with-eval-after-load 'company
  (progn
    (require 'company-c-headers)
  )
)
(defun pan/init-company-c-headers()
  (use-package company-c-headers
    ;; :location (recipe
    ;;            :fetcher githu
    ;;            )
    :defer t
    :init
    (add-to-list 'company-c-headers-path-system "/usr/include/c++/4.8")
    (add-to-list 'company-c-headers-path-system "/usr/include/glib-2.0")
    (add-to-list 'company-c-headers-path-system "/usr/include/glib-2.0/glib")
    :config
    (progn
      (add-to-list 'company-backends 'company-c-headers)
    )
    ;; (Auto-complete-mode enable)
    ))
(defun pan/init-lispy()
  (use-package lispy
    :defer t
    :init
    :bind))
;;(unbind-key "M-j" evil-window-next)
(global-set-key (kbd "M-r") 'nil)
(defun pan/init-markdown-mode ()
  (use-package markdown-mode
    :init
    :config
    ;; (use-package moccur-edit)
;;    (unbind-key "M-n" markdown-next-link)
   :bind
   (
    ("M-r -" . org-ctrl-c-minus)
    ("M-r h" . markdown-insert-header)
    ("M-r 1" . markdown-insert-header-atx-1)
    ("M-r 2" . markdown-insert-header-atx-2)
    ("M-r 3" . markdown-insert-header-atx-3)
    ("M-r l" . markdown-insert-link-button)
    ("M-r u" . markdown-insert-uri)
    ("M-r t" . table-insert)
    ("M-r c" . markdown-insert-gfm-code-block)
    ("M-r q" . markdown-insert-blockquote)
    ("M-r q" . markdown-insert-blockquote)
    ("M-r i" . markdown-insert-italic)
    ("M-r b" . markdown-insert-bold))
   ))
(defun pan/init-yasnippet()
  (use-package yasnippet
    :defer t
    :init
    :bind (("C-x l" . yas-describe-tables)
           )
    ))
(defun pan/post-init-yasnippet ()
  (progn
    (set-face-background 'secondary-selection "gray")
    (setq-default yas-prompt-functions '(yas-ido-prompt yas-dropdown-prompt))
    (spacemacs/add-to-hooks 'pan/load-yasnippet '(prog-mode-hook
                                                            markdown-mode-hook
                                                            org-mode-hook
                                                            c-mode-hook))
    ))

(defun pan/init-yasnippet-snippets()
  (use-package yasnippet-snippets
    :defer t
    :init
    ))
;;(spacemacs|add-company-hook c++-mode)
;;(push 'company-keywords company-backends-org-mode)
  ;; (setq company-backends-c++-mode '((company-dabbrev-code
  ;;                                    company-keywords
  ;;                                    company-etags)
  ;;                                   company-files company-dabbrev)))
(defun pan/init-elpy ()
  (use-package elpy
    :defer t
    :init
    (elpy-enable)
    )
  )
(defun pan/init-fcitx ()
  (use-package fcitx
    :defer t
    :init
    (setq  fcitx-active-evil-states '(insert emacs hybrid))
    ))
(defun pan/init-youdao-dictionary ()
  (use-package youdao-dictionary
    :defer t
    :init
    (spacemacs/set-leader-keys "oy" 'youdao-dictionary-search-at-point+)
    )
  )
;;(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; ======================================dired mode key-binding====================================
;; add `flet'
(load "pan_org.el")
(load "pan_dired.el")
(load "pan_python.el")
(load "pan_tag.el")
(load "pan_c-c++.el")
(load "pan_ggtags.el")
(load "pan_yasnippet.el")


(require 'cl)

(require 'dired-x)

(require 'dired-aux)

;; configure for search
(spacemacs/set-leader-keys "sp" 'helm-ag-project-root)
;; c-c c-e edit helm-ag result
(add-hook 'js2-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'flycheck-mode)
;; use flycheck-list-errors to display all error

;; mimic "nzz"behavious in vim, but sense no use
(defadvice evil-search-next (after advice-for-evil-search-next activate)
  (evil-scroll-line-to-center (line-number-at-pos)))

(defadvice evil-search-previous (after advice-for-evil-search-previous activate)
  (evil-scroll-line-to-center (line-number-at-pos)))

;; python key-binding
;; (add-hook 'c++-mode-hook 'ycmd-mode)
;; (setq ycmd-server-command '("python" "/home/hadoop2/ycmd/ycmd/"))
