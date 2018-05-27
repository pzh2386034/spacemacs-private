;; insert mode key-bindings

(define-key evil-insert-state-map (kbd "s-j") 'next-line)
(define-key evil-insert-state-map (kbd "s-k") 'previous-line)
(define-key evil-insert-state-map (kbd "s-l") 'right-char)
(define-key evil-insert-state-map (kbd "s-h") 'left-char)
(define-key evil-insert-state-map (kbd "s-e") 'move-end-of-line)
(define-key evil-insert-state-map (kbd "s-a") 'move-beginning-of-line)

(global-set-key (kbd "s-w") 'nil)
(global-set-key (kbd "s-W") 'nil)
(global-set-key (kbd "s-w") 'split-window-below-and-focus)
(global-set-key (kbd "s-W") 'split-window-right-and-focus)
(global-set-key (kbd "s-o") 'occur)
(global-set-key (kbd "C-c t") 'terminal)
(global-set-key (kbd "C-c T") 'named-term)



;;; redefine company bar roll keybindings and make sure keybindings

