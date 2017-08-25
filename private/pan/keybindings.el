;; c c++ key-binding
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(custom-set-variables
 '(helm-gtags-path-style 'relative)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-auto-update t))

;; key bindings
(with-eval-after-load 'helm-gtags
  (define-key helm-gtags-mode-map (kbd "M-g t") 'helm-gtags-find-tag)
  (define-key helm-gtags-mode-map (kbd "M-g r") 'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "M-g s") 'helm-gtags-find-symbol)
  (define-key helm-gtags-mode-map (kbd "M-g p") 'helm-gtags-parse-file)
  (define-key helm-gtags-mode-map (kbd "M-<") 'helm-gtags-previous-history)
  (define-key helm-gtags-mode-map (kbd "M->") 'helm-gtags-next-history)
  (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
  (define-key helm-gtags-mode-map (kbd "M-g c") 'helm-gtags-create-tags)
  (define-key helm-gtags-mode-map (kbd "M-g D") 'helm-gtags-dwim-other-window)
  (define-key helm-gtags-mode-map (kbd "M-g d") 'helm-gtags-dwim)
  (define-key helm-gtags-mode-map (kbd "M-g f") 'helm-gtags-tags-in-this-function)
  (define-key helm-gtags-mode-map (kbd "M-g k") 'helm-gtags-show-stack)
  (define-key helm-gtags-mode-map (kbd "M-g a") 'helm-gtags-clear-stack)
  )
(with-eval-after-load 'auto-complete
  (auto-complete-mode 1))
;; python key-binding
(define-key evil-insert-state-map (kbd "M-j") 'next-line)
(define-key evil-insert-state-map (kbd "M-k") 'previous-line)
(define-key evil-insert-state-map (kbd "M-l") 'right-char)
(define-key evil-insert-state-map (kbd "M-h") 'left-char)
(with-eval-after-load 'elpy
  (define-key python-mode-map (kbd "M-g \'") 'python-start-or-switch-repl)
  (define-key python-mode-map (kbd "M-g h") 'anaconda-eldoc-mode)
  )
;; (custom-set-variables
;;  '(helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
;;  '(helm-ag-command-option "--all-test")
;;  '(helm-ag--insert-thing-at-point 'symbol)
;;  '(helm-ag-ignore-buffer-pattern '("\\.txt\\'" "\\.mkd\\'")))
 (with-eval-after-load 'helm-gtags
  (define-key helm-gtags-mode-map (kbd "M-h d") 'helm-ag)
  (define-key helm-gtags-mode-map (kbd "M-h t") 'helm-ag-this-file)
  (define-key helm-gtags-mode-map (kbd "M-h b") 'helm-ag-buffers)
  (define-key helm-gtags-mode-map (kbd "M-h p") 'helm-ag-project-root)
  (define-key helm-gtags-mode-map (kbd "M-h D") 'helm-do-ag)
  (define-key helm-gtags-mode-map (kbd "M-h T") 'helm-do-ag-this-file)
  (define-key helm-gtags-mode-map (kbd "M-h B") 'helm-do-ag-buffers)
  (define-key helm-gtags-mode-map (kbd "M-h P") 'helm-do-ag-project-root)
  (define-key helm-gtags-mode-map (kbd "M-h c") 'helm-ag-clear-stack)
  (define-key helm-gtags-mode-map (kbd "M-h o") 'helm-ag-pop-stack)
  )

(add-hook 'c-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '( auto-complete   company-gtags company-files  company-dabbrev))
            (spacemacs/set-leader-keys "oh" 'anaconda-mode-show-doc)
            ))
;; (define-key c-mode-map (kbd "M-c f") 'clang-format-region)
(add-hook 'c-mode-hook 'clang-format-bindings-c)
(add-hook 'c++-mode-hook 'clang-format-bindings-cpp)
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
