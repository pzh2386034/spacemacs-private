;; insert mode key-bindings

(define-key evil-insert-state-map (kbd "s-j") 'next-line)
(define-key evil-insert-state-map (kbd "s-k") 'previous-line)
(define-key evil-insert-state-map (kbd "s-l") 'right-char)
(define-key evil-insert-state-map (kbd "s-h") 'left-char)
(define-key evil-insert-state-map (kbd "s-e") 'move-end-of-line)
(define-key evil-insert-state-map (kbd "s-a") 'move-beginning-of-line)

(global-set-key (kbd "C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-\\") 'highlight-symbol-at-point)
(global-set-key (kbd "s-w") 'split-window-below-and-focus)
(global-set-key (kbd "s-W") 'split-window-right-and-focus)
(global-set-key (kbd "s-o") 'occur)
(global-set-key (kbd "C-c t") 'terminal)
(global-set-key (kbd "C-c T") 'named-term)

(setq make-backup-file nil)
(setq-default toggle-truncate-line t) ;; auto truncate lines

(add-to-list 'load-path "~/.spacemacs.d/private/pan/") ;; add .el auto search directory

;;; redefine company bar roll keybindings and make sure keybindings
(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))


