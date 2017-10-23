
(setq-default dotspacemacs-configuration-layers
              '((auto-completion :variables
                                 auto-completion-enable-snippets-in-popup t)))
(add-hook 'c-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '( auto-complete   company-gtags company-files  company-dabbrev))
            (spacemacs/set-leader-keys "sb" 'backward-sexp)
            (spacemacs/set-leader-keys "sm" 'mark-sexp)
            (spacemacs/set-leader-keys "sk" 'kill-sexp)
            (spacemacs/set-leader-keys "sf" 'forward-sexp)
            (spacemacs/set-leader-keys "fb" 'beginning-of-defun)
            (spacemacs/set-leader-keys "fe" 'end-of-defun)
            (spacemacs/set-leader-keys "fm" 'mark-defun)
            ))
(add-hook 'c++-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '( auto-complete   company-gtags company-files company-ya company-dabbrev))
            (spacemacs/set-leader-keys "sb" 'backward-sexp)
            (spacemacs/set-leader-keys "sm" 'mark-sexp)
            (spacemacs/set-leader-keys "sk" 'kill-sexp)
            (spacemacs/set-leader-keys "sf" 'forward-sexp)
            (spacemacs/set-leader-keys "fb" 'beginning-of-defun)
            (spacemacs/set-leader-keys "fe" 'end-of-defun)
            (spacemacs/set-leader-keys "fm" 'mark-defun)
            ))


(add-hook 'c-mode-hook 'clang-format-bindings-c)
(add-hook 'c++-mode-hook 'clang-format-bindings-cpp)
