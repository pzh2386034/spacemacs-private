;; set configs

;; set hot key for org-mode
(add-hook 'org-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '( auto-complete   company-files  company-dabbrev ))
            (spacemacs/set-leader-keys (kbd "os") 'org-schedule)
            (spacemacs/set-leader-keys (kbd "od") 'org-deadline)
            (local-unset-key (kbd "s-l"))
            (local-unset-key (kbd "s-n"))
            (local-unset-key (kbd "s-j"))
            (local-unset-key (kbd "s-k"))
            (define-key evil-insert-state-map (kbd "s-j") 'next-line)
            (define-key evil-insert-state-map (kbd "s-k") 'previous-line)
            (define-key evil-insert-state-map (kbd "s-l") 'right-char)
            (define-key evil-insert-state-map (kbd "s-h") 'left-char)
            ))

(add-hook 'org-mode-hook 'org-indent-mode)

(add-hook 'prog-mode-hook 'clean-aindent-mode)
(add-hook 'prog-mode-hook (lambda ()
                            (interactive)
                            (setq show-trailing-whitespace 1)))

(setq-default toggle-truncate-line t) ;; auto truncate lines
(setq make-backup-file nil)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))
