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
(global-unset-key (kbd "s-p"))
(global-unset-key (kbd "s-n"))
(global-unset-key (kbd "s-m"))
(global-unset-key (kbd "M-u"))
(global-set-key (kbd "s-p s") 'org-schedule)
(global-set-key (kbd "s-p d") 'org-deadline)
(global-set-key (kbd "s-p a") 'org-agenda)
(global-set-key (kbd "s-p c") 'org-capture)
(global-set-key (kbd "s-p l") 'org-agenda-list)
(global-set-key (kbd "s-p v") 'org-tags-view)
;; (with-eval-after-load 'org-projectile
;;   (global-set-key (kbd "s-p p") 'org-projectile/capture)
;;   (global-set-key (kbd "s-p d") 'org-projectile/goto-todos))

(global-set-key (kbd "s-x") 'nil)
(global-set-key (kbd "s-x") 'helm-M-x )
;; (global-set-key (kbd "s-w") 'nil)
;; (global-set-key (kbd "s-W") 'nil)
(global-set-key (kbd "s-b") 'split-window-below-and-focus)
(global-set-key (kbd "s-r") 'split-window-right-and-focus)
(global-set-key (kbd "s-o") 'occur)
(global-set-key (kbd "C-c t") 'terminal)
(global-set-key (kbd "C-c T") 'named-term)
(global-unset-key (kbd "C-i"))

;;; comment keybindings
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
  (define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
  (define-key evil-normal-state-map (kbd "C-i") 'evil-jump-forward)
  (define-key evil-visual-state-map (kbd "C-i") 'evil-jump-forward)
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
  (define-key emacs-lisp-mode-map (kbd "s-h P") 'helm-ag-project-root)
  (define-key emacs-lisp-mode-map (kbd "s-h D") 'helm-do-ag)
  (define-key emacs-lisp-mode-map (kbd "s-h T") 'helm-do-ag-this-file)
  (define-key emacs-lisp-mode-map (kbd "s-h B") 'helm-do-ag-buffers)
  (define-key emacs-lisp-mode-map (kbd "s-h p") 'helm-do-ag-project-root)
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
  ;; (define-key c-mode-map (kbd "s-h d") 'helm-ag)
  (define-key c-mode-map (kbd "s-h t") 'helm-ag-this-file)
  (define-key c-mode-map (kbd "s-h b") 'helm-ag-buffers)
  (define-key c-mode-map (kbd "s-h P") 'helm-ag-project-root)
  (define-key c-mode-map (kbd "s-h D") 'helm-do-ag)
  (define-key c-mode-map (kbd "s-h T") 'helm-do-ag-this-file)
  (define-key c-mode-map (kbd "s-h B") 'helm-do-ag-buffers)
  (define-key c-mode-map (kbd "s-h p") 'helm-do-ag-project-root)
  (define-key c-mode-map (kbd "s-h c") 'helm-ag-clear-stack)
  (define-key c-mode-map (kbd "s-h o") 'helm-ag-pop-stack)
  (define-key c-mode-map (kbd "s-h d") 'helm-dash)
  (define-key c-mode-map (kbd "s-h a") 'helm-dash-at-point)

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
  ;; (define-key c++-mode-map (kbd "s-g a") 'helm-gtags-clear-stack)
  ;; (define-key c++-mode-map (kbd "s-h d") 'helm-ag)
  (define-key c++-mode-map (kbd "s-h t") 'helm-ag-this-file)
  (define-key c++-mode-map (kbd "s-h b") 'helm-ag-buffers)
  (define-key c++-mode-map (kbd "s-h P") 'helm-ag-project-root)
  (define-key c++-mode-map (kbd "s-h D") 'helm-do-ag)
  (define-key c++-mode-map (kbd "s-h T") 'helm-do-ag-this-file)
  (define-key c++-mode-map (kbd "s-h B") 'helm-do-ag-buffers)
  (define-key c++-mode-map (kbd "s-h p") 'helm-do-ag-project-root)
  (define-key c++-mode-map (kbd "s-h c") 'helm-ag-clear-stack)
  (define-key c++-mode-map (kbd "s-h o") 'helm-ag-pop-stack)
  (define-key c++-mode-map (kbd "s-h d") 'helm-dash)
  (define-key c++-mode-map (kbd "s-h a") 'helm-dash-at-point)
  )

;; set key binding for dash
;; add awesome-pair

(require 'awesome-pair)

(dolist (hook (list
               'c-mode-common-hook
               'c-mode-hook
               'c++-mode-hook
               'java-mode-hook
               'haskell-mode-hook
               'emacs-lisp-mode-hook
               'lisp-interaction-mode-hook
               'lisp-mode-hook
               'maxima-mode-hook
               'ielm-mode-hook
               'sh-mode-hook
               'makefile-gmake-mode-hook
               'php-mode-hook
               'python-mode-hook
               'js-mode-hook
               'go-mode-hook
               'qml-mode-hook
               'jade-mode-hook
               'css-mode-hook
               'ruby-mode-hook
               'coffee-mode-hook
               'rust-mode-hook
               'qmake-mode-hook
               'lua-mode-hook
               'swift-mode-hook
               'minibuffer-inactive-mode-hook
               ))
  (add-hook hook '(lambda () (awesome-pair-mode 1))))

(define-key awesome-pair-mode-map (kbd "(") 'awesome-pair-open-round)
(define-key awesome-pair-mode-map (kbd "[") 'awesome-pair-open-bracket)
(define-key awesome-pair-mode-map (kbd "{") 'awesome-pair-open-curly)
;; (define-key awesome-pair-mode-map (kbd ")") 'awesome-pair-close-round)
;; (define-key awesome-pair-mode-map (kbd "]") 'awesome-pair-close-bracket)
;; (define-key awesome-pair-mode-map (kbd "}") 'awesome-pair-close-curly)
(define-key awesome-pair-mode-map (kbd "s-m") 'awesome-pair-match-paren)
(define-key awesome-pair-mode-map (kbd "\"") 'awesome-pair-double-quote)
(define-key awesome-pair-mode-map (kbd "M-o") 'awesome-pair-backward-delete)
(define-key awesome-pair-mode-map (kbd "M-k") 'awesome-pair-kill)
(define-key awesome-pair-mode-map (kbd "M-\"") 'awesome-pair-wrap-double-quote)
(define-key awesome-pair-mode-map (kbd "M-[") 'awesome-pair-wrap-bracket)
(define-key awesome-pair-mode-map (kbd "M-{") 'awesome-pair-wrap-curly)
(define-key awesome-pair-mode-map (kbd "M-(") 'awesome-pair-wrap-round)
(define-key awesome-pair-mode-map (kbd "M-)") 'awesome-pair-unwrap)
(define-key awesome-pair-mode-map (kbd "M-p") 'awesome-pair-jump-right)
(define-key awesome-pair-mode-map (kbd "M-n") 'awesome-pair-jump-left)
(define-key awesome-pair-mode-map (kbd "M-:") 'awesome-pair-jump-out-pair-and-newline)

;; symbol-overlay
;; Or you may prefer to overwrite the keymap

;; (let ((map (make-sparse-keymap)))
;;   (define-key map (kbd "key1") 'command-1)
;;   (define-key map (kbd "key2") 'command-2)
;;   (setq symbol-overlay-map map))
(require 'symbol-overlay)
(setq symbol-overlay-mode 1)
(global-set-key (kbd "M-i") 'symbol-overlay-put)
(global-set-key (kbd "M-n") 'symbol-overlay-switch-forward)
(global-set-key (kbd "M-p") 'symbol-overlay-switch-backward)
(global-set-key (kbd "M-c") 'symbol-overlay-remove-all)
(define-key symbol-overlay-map (kbd "<") 'symbol-overlay-switch-first)
(define-key symbol-overlay-map (kbd ">") 'symbol-overlay-switch-last)
