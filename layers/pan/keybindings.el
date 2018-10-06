;; insert mode key-bindings



(define-key evil-insert-state-map (kbd "s-j") 'next-line)
(define-key evil-insert-state-map (kbd "s-k") 'previous-line)
(define-key evil-insert-state-map (kbd "s-l") 'right-char)
(define-key evil-insert-state-map (kbd "s-h") 'left-char)
(define-key evil-insert-state-map (kbd "s-e") 'move-end-of-line)
(define-key evil-insert-state-map (kbd "s-a") 'move-beginning-of-line)
(define-key evil-normal-state-map (kbd "s-e") 'move-end-of-line)
(define-key evil-normal-state-map (kbd "s-a") 'move-beginning-of-line)
(define-key yas-minor-mode-map (kbd "TAB") 'yas-expand-from-trigger-key)

(global-set-key (kbd "s-x") 'nil)
(global-set-key (kbd "s-x") 'helm-M-x )
;; (global-set-key (kbd "s-w") 'nil)
;; (global-set-key (kbd "s-W") 'nil)
(global-set-key (kbd "s-b") 'split-window-below-and-focus)
(global-set-key (kbd "s-r") 'split-window-right-and-focus)
(global-set-key (kbd "s-o") 'occur)
(global-set-key (kbd "C-c t") 'terminal)
(global-set-key (kbd "C-c T") 'named-term)

;;; comment keybindings
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
  (define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
  )

(defun clang-format-bindings-c ()
  (define-key c-mode-map (kbd "s-c f") 'clang-format-region)
  (define-key c-mode-map (kbd "s-c b") 'clang-format-buffer)
  (lambda () (setq flycheck-clang-include-path
                   (list (expand-file-name "~/local/include/"))))
  )
(defun clang-format-bindings-cpp ()
  (define-key c++-mode-map (kbd "s-c f") 'clang-format-region)
  (define-key c++-mode-map (kbd "s-c b") 'clang-format-buffer)
  )
(with-eval-after-load 'hideshow
  (define-key c-mode-map (kbd "s-c h") 'hs-toggle-hiding)
  (define-key c-mode-map (kbd "s-c a") 'hs-hide-all)
  (define-key c-mode-map (kbd "s-c l") 'hs-hide-level)
  (define-key c++-mode-map (kbd "s-c h") 'hs-toggle-hiding)
  (define-key c++-mode-map (kbd "s-c a") 'hs-hide-all)
  (define-key c++-mode-map (kbd "s-c l") 'hs-hide-level)
  (define-key emacs-lisp-mode-map (kbd "s-c h") 'hs-toggle-hiding)
  (define-key emacs-lisp-mode-map (kbd "s-c a") 'hs-hide-all)
  (define-key emacs-lisp-mode-map (kbd "s-c l") 'hs-hide-level)
  )

(with-eval-after-load 'markdown-mode
  (define-key markdown-mode-map (kbd "s-r h") 'markdown-insert-header)
  (define-key markdown-mode-map (kbd "s-r 1") 'markdown-insert-header-atx-1)
  (define-key markdown-mode-map (kbd "s-r 2") 'markdown-insert-header-atx-2)
  (define-key markdown-mode-map (kbd "s-r 3") 'markdown-insert-header-atx-3)
  (define-key markdown-mode-map (kbd "s-r l") 'markdown-insert-link-button)
  (define-key markdown-mode-map (kbd "s-r u") 'markdown-insert-uri)
  (define-key markdown-mode-map (kbd "s-r t") 'table-insert)
  (define-key markdown-mode-map (kbd "s-r c") 'markdown-insert-gfm-code-block)
  (define-key markdown-mode-map (kbd "s-r q") 'markdown-insert-blockquote)
  (define-key markdown-mode-map (kbd "s-r i") 'markdown-insert-italic)
  (define-key markdown-mode-map (kbd "s-r b") 'markdown-insert-bold)
)

(with-eval-after-load 'helm-gtags
  (define-key emacs-lisp-mode-map (kbd "s-g s") 'helm-gtags-select)
  (define-key emacs-lisp-mode-map (kbd "s-g r") 'helm-gtags-find-rtag)
  (define-key emacs-lisp-mode-map (kbd "s-g f") 'helm-gtags-find-symbol)
  (define-key emacs-lisp-mode-map (kbd "s-<") 'helm-gtags-previous-history)
  (define-key emacs-lisp-mode-map (kbd "s->") 'helm-gtags-next-history)
  (define-key emacs-lisp-mode-map (kbd "s-,") 'helm-gtags-pop-stack)
  (define-key emacs-lisp-mode-map (kbd "s-g c") 'helm-gtags-create-tags)
  (define-key emacs-lisp-mode-map (kbd "s-g D") 'helm-gtags-dwim-other-window)
  (define-key emacs-lisp-mode-map (kbd "s-g d") 'helm-gtags-dwim)
  (define-key emacs-lisp-mode-map (kbd "s-g t") 'helm-gtags-tags-in-this-function)
  (define-key emacs-lisp-mode-map (kbd "s-g k") 'helm-gtags-show-stack)
  (define-key emacs-lisp-mode-map (kbd "s-g a") 'helm-gtags-clear-stack)
  (define-key emacs-lisp-mode-map (kbd "s-h d") 'helm-ag)
  (define-key emacs-lisp-mode-map (kbd "s-h t") 'helm-ag-this-file)
  (define-key emacs-lisp-mode-map (kbd "s-h b") 'helm-ag-buffers)
  (define-key emacs-lisp-mode-map (kbd "s-h p") 'helm-ag-project-root)
  (define-key emacs-lisp-mode-map (kbd "s-h D") 'helm-do-ag)
  (define-key emacs-lisp-mode-map (kbd "s-h T") 'helm-do-ag-this-file)
  (define-key emacs-lisp-mode-map (kbd "s-h B") 'helm-do-ag-buffers)
  (define-key emacs-lisp-mode-map (kbd "s-h P") 'helm-do-ag-project-root)
  (define-key emacs-lisp-mode-map (kbd "s-h c") 'helm-ag-clear-stack)
  (define-key emacs-lisp-mode-map (kbd "s-h o") 'helm-ag-pop-stack)

  (define-key c-mode-map (kbd "s-g s") 'helm-gtags-select)
  (define-key c-mode-map (kbd "s-g r") 'helm-gtags-find-rtag)
  (define-key c-mode-map (kbd "s-g f") 'helm-gtags-find-symbol)
  (define-key c-mode-map (kbd "s-<") 'helm-gtags-previous-history)
  (define-key c-mode-map (kbd "s->") 'helm-gtags-next-history)
  (define-key c-mode-map (kbd "s-,") 'helm-gtags-pop-stack)
  (define-key c-mode-map (kbd "s-g c") 'helm-gtags-create-tags)
  (define-key c-mode-map (kbd "s-g D") 'helm-gtags-dwim-other-window)
  (define-key c-mode-map (kbd "s-g d") 'helm-gtags-dwim)
  (define-key c-mode-map (kbd "s-g t") 'helm-gtags-tags-in-this-function)
  (define-key c-mode-map (kbd "s-g k") 'helm-gtags-show-stack)
  (define-key c-mode-map (kbd "s-g a") 'helm-gtags-clear-stack)
  (define-key c-mode-map (kbd "s-h d") 'helm-ag)
  (define-key c-mode-map (kbd "s-h t") 'helm-ag-this-file)
  (define-key c-mode-map (kbd "s-h b") 'helm-ag-buffers)
  (define-key c-mode-map (kbd "s-h p") 'helm-ag-project-root)
  (define-key c-mode-map (kbd "s-h D") 'helm-do-ag)
  (define-key c-mode-map (kbd "s-h T") 'helm-do-ag-this-file)
  (define-key c-mode-map (kbd "s-h B") 'helm-do-ag-buffers)
  (define-key c-mode-map (kbd "s-h P") 'helm-do-ag-project-root)
  (define-key c-mode-map (kbd "s-h c") 'helm-ag-clear-stack)
  (define-key c-mode-map (kbd "s-h o") 'helm-ag-pop-stack)

  (define-key c++-mode-map (kbd "s-g s") 'helm-gtags-select)
  (define-key c++-mode-map (kbd "s-g r") 'helm-gtags-find-rtag)
  (define-key c++-mode-map (kbd "s-g f") 'helm-gtags-find-symbol)
  (define-key c++-mode-map (kbd "s-<") 'helm-gtags-previous-history)
  (define-key c++-mode-map (kbd "s->") 'helm-gtags-next-history)
  (define-key c++-mode-map (kbd "s-,") 'helm-gtags-pop-stack)
  (define-key c++-mode-map (kbd "s-g c") 'helm-gtags-create-tags)
  (define-key c++-mode-map (kbd "s-g D") 'helm-gtags-dwim-other-window)
  (define-key c++-mode-map (kbd "s-g d") 'helm-gtags-dwim)
  (define-key c++-mode-map (kbd "s-g t") 'helm-gtags-tags-in-this-function)
  (define-key c++-mode-map (kbd "s-g k") 'helm-gtags-show-stack)
  (define-key c++-mode-map (kbd "s-g a") 'helm-gtags-clear-stack)
  (define-key c++-mode-map (kbd "s-h d") 'helm-ag)
  (define-key c++-mode-map (kbd "s-h t") 'helm-ag-this-file)
  (define-key c++-mode-map (kbd "s-h b") 'helm-ag-buffers)
  (define-key c++-mode-map (kbd "s-h p") 'helm-ag-project-root)
  (define-key c++-mode-map (kbd "s-h D") 'helm-do-ag)
  (define-key c++-mode-map (kbd "s-h T") 'helm-do-ag-this-file)
  (define-key c++-mode-map (kbd "s-h B") 'helm-do-ag-buffers)
  (define-key c++-mode-map (kbd "s-h P") 'helm-do-ag-project-root)
  (define-key c++-mode-map (kbd "s-h c") 'helm-ag-clear-stack)
  (define-key c++-mode-map (kbd "s-h o") 'helm-ag-pop-stack)
  )
