(setq
  helm-gtags-ignore-case t
  helm-gtags-auto-update t
  helm-gtags-use-input-at-cursor t
  helm-gtags-pulse-at-cursor t
  helm-gtags-prefix-key "\C-cg"
  helm-gtags-suggested-key-mapping t
  )

;; (require 'helm-gtags)
 ;; Enable helm-gtags-mode
 (add-hook 'dired-mode-hook 'helm-gtags-mode)
 (add-hook 'eshell-mode-hook 'helm-gtags-mode)
 (add-hook 'c-mode-hook 'helm-gtags-mode)
 (add-hook 'c++-mode-hook 'helm-gtags-mode)
 (add-hook 'asm-mode-hook 'helm-gtags-mode)


(with-eval-after-load 'helm-gtags
  (define-key helm-gtags-mode-map (kbd "M-g s") 'helm-gtags-select)
  (define-key helm-gtags-mode-map (kbd "M-g r") 'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "M-g f") 'helm-gtags-find-symbol)
  (define-key helm-gtags-mode-map (kbd "M-<") 'helm-gtags-previous-history)
  (define-key helm-gtags-mode-map (kbd "M->") 'helm-gtags-next-history)
  (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
  (define-key helm-gtags-mode-map (kbd "M-g c") 'helm-gtags-create-tags)
  (define-key helm-gtags-mode-map (kbd "M-g D") 'helm-gtags-dwim-other-window)
  (define-key helm-gtags-mode-map (kbd "M-g d") 'helm-gtags-dwim)
  (define-key helm-gtags-mode-map (kbd "M-g t") 'helm-gtags-tags-in-this-function)
  (define-key helm-gtags-mode-map (kbd "M-g k") 'helm-gtags-show-stack)
  (define-key helm-gtags-mode-map (kbd "M-g a") 'helm-gtags-clear-stack)
  )

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

