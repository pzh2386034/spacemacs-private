(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
  (define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
  )
;; leanrn anacoda mode
(add-hook 'python-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '(company-anaconda company-dabbrev))
            (spacemacs/set-leader-keys "or" 'anaconda-mode-find-references)
            (spacemacs/set-leader-keys "om" 'anaconda-mode-complete)
            (spacemacs/set-leader-keys "od" 'anaconda-mode-find-definitions)
            (spacemacs/set-leader-keys "os" 'anaconda-mode-find-assignments)
            (spacemacs/set-leader-keys "ob" 'anaconda-mode-go-back)
            (spacemacs/set-leader-keys "oh" 'anaconda-mode-show-doc)
            ))
;;(define-key python-mode-hook (kbd ""))
;; (add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)
(with-eval-after-load 'elpy
  (define-key python-mode-map (kbd "M-g \'") 'python-start-or-switch-repl)
  (define-key python-mode-map (kbd "M-g h") 'anaconda-eldoc-mode)
  )
