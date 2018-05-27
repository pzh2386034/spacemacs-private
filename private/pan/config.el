;; set configs

;; set hot key for org-mode
(add-hook 'org-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '( auto-complete   company-files  company-dabbrev ))
            (spacemacs/set-leader-keys (kbd "os") 'org-schedule)
            (spacemacs/set-leader-keys (kbd "od") 'org-deadline)
            (local-unset-key (kbd "M-l"))
            (local-unset-key (kbd "M-n"))
            (local-unset-key (kbd "M-j"))
            (local-unset-key (kbd "M-k"))
            (define-key evil-insert-state-map (kbd "M-j") 'next-line)
            (define-key evil-insert-state-map (kbd "M-k") 'previous-line)
            (define-key evil-insert-state-map (kbd "M-l") 'right-char)
            (define-key evil-insert-state-map (kbd "M-h") 'left-char)
            ))

(add-hook 'org-mode-hook 'org-indent-mode)

