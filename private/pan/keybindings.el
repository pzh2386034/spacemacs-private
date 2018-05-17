;; c c++ key-binding
;; key bindings
;; (with-eval-after-load 'auto-complete
;;   (auto-complete-mode 1))
;; python key-binding
(define-key evil-insert-state-map (kbd "M-j") 'next-line)
(define-key evil-insert-state-map (kbd "M-k") 'previous-line)
(define-key evil-insert-state-map (kbd "M-l") 'right-char)
(define-key evil-insert-state-map (kbd "M-h") 'left-char)
;; (define-key c-mode-map (kbd "M-c f") 'clang-format-region)
(defun clang-format-bindings-c ()
  (define-key c-mode-map (kbd "M-c f") 'clang-format-region)
  (define-key c-mode-map (kbd "M-c b") 'clang-format-buffer)
  (lambda () (setq flycheck-clang-include-path
                   (list (expand-file-name "~/local/include/"))))
  )
(defun clang-format-bindings-cpp ()
  (define-key c++-mode-map (kbd "M-c f") 'clang-format-region)
  (define-key c++-mode-map (kbd "M-c b") 'clang-format-buffer)
  )
(with-eval-after-load 'hideshow
  (define-key c-mode-map (kbd "M-c h") 'hs-toggle-hiding)
  (define-key c-mode-map (kbd "M-c a") 'hs-hide-all)
  (define-key c-mode-map (kbd "M-c l") 'hs-hide-level)
  (define-key c++-mode-map (kbd "M-c h") 'hs-toggle-hiding)
  (define-key c++-mode-map (kbd "M-c a") 'hs-hide-all)
  (define-key c++-mode-map (kbd "M-c l") 'hs-hide-level)
  (define-key emacs-lisp-mode-map (kbd "M-c h") 'hs-toggle-hiding)
  (define-key emacs-lisp-mode-map (kbd "M-c a") 'hs-hide-all)
  (define-key emacs-lisp-mode-map (kbd "M-c l") 'hs-hide-level)
  )
