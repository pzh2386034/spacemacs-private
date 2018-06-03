(setq
  helm-gtags-ignore-case t
  helm-gtags-auto-update t
  helm-gtags-use-input-at-cursor t
  helm-gtags-pulse-at-cursor t
  helm-gtags-prefix-key "\C-cg"
  helm-gtags-suggested-key-mapping t
  )

;;(require 'helm-gtags)
 ;; Enable helm-gtags-mode
 (add-hook 'dired-mode-hook 'helm-gtags-mode)
 (add-hook 'eshell-mode-hook 'helm-gtags-mode)
 (add-hook 'c-mode-hook 'helm-gtags-mode)
 (add-hook 'c++-mode-hook 'helm-gtags-mode)
 (add-hook 'asm-mode-hook 'helm-gtags-mode)

(set 'helm-gtags-mode t)


(with-eval-after-load 'helm-gtags
  (define-key helm-gtags-mode-map (kbd "s-g s") 'helm-gtags-select)
  (define-key helm-gtags-mode-map (kbd "s-g r") 'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "s-g f") 'helm-gtags-find-symbol)
  (define-key helm-gtags-mode-map (kbd "s-<") 'helm-gtags-previous-history)
  (define-key helm-gtags-mode-map (kbd "s->") 'helm-gtags-next-history)
  (define-key helm-gtags-mode-map (kbd "s-,") 'helm-gtags-pop-stack)
  (define-key helm-gtags-mode-map (kbd "s-g c") 'helm-gtags-create-tags)
  (define-key helm-gtags-mode-map (kbd "s-g D") 'helm-gtags-dwim-other-window)
  (define-key helm-gtags-mode-map (kbd "s-g d") 'helm-gtags-dwim)
  (define-key helm-gtags-mode-map (kbd "s-g t") 'helm-gtags-tags-in-this-function)
  (define-key helm-gtags-mode-map (kbd "s-g k") 'helm-gtags-show-stack)
  (define-key helm-gtags-mode-map (kbd "s-g a") 'helm-gtags-clear-stack)
  )

(with-eval-after-load 'helm-gtags
  (define-key helm-gtags-mode-map (kbd "s-h d") 'helm-ag)
  (define-key helm-gtags-mode-map (kbd "s-h t") 'helm-ag-this-file)
  (define-key helm-gtags-mode-map (kbd "s-h b") 'helm-ag-buffers)
  (define-key helm-gtags-mode-map (kbd "s-h p") 'helm-ag-project-root)
  (define-key helm-gtags-mode-map (kbd "s-h D") 'helm-do-ag)
  (define-key helm-gtags-mode-map (kbd "s-h T") 'helm-do-ag-this-file)
  (define-key helm-gtags-mode-map (kbd "s-h B") 'helm-do-ag-buffers)
  (define-key helm-gtags-mode-map (kbd "s-h P") 'helm-do-ag-project-root)
  (define-key helm-gtags-mode-map (kbd "s-h c") 'helm-ag-clear-stack)
  (define-key helm-gtags-mode-map (kbd "s-h o") 'helm-ag-pop-stack)
)

