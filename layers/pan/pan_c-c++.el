
(require 'cc-mode)
(require 'semantic)
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-highlight-func-mode 1) ;; active highlighting of first line for current tag
(global-semantic-stickyfunc-mode 1) ;; activates mode when name of current tag will be shown in top line of buffer
(global-semantic-idle-local-symbol-highlight-mode 1) ;; activates highlighting of local names that are the same as name of tag under cursor;
(global-semantic-idle-scheduler-mode 1) ;; activates automatic parsing of source code in the idle time;
(require 'semantic/ia)

(semantic-mode 1)

(setq-default dotspacemacs-configuration-layers
              '((auto-completion :variables
                                 auto-completion-enable-snippets-in-popup t)))
(add-hook 'c-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '(company-semantic company-c-headers company-dabbrev-code  company-gtags company-files company-keywords company-dabbrev))
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
            (set (make-local-variable 'company-backends) '(company-semantic company-c-headers  company-dabbrev-code  company-gtags company-c-headers company-keywords company-files company-dabbrev))
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

(with-eval-after-load 'company-c-headers
  (add-to-list 'company-c-headers-path-system "/usr/include/c++/4.2.1")
)
;; cedet semantic for c, c++
;; (semantic-add-system-include "~/linux/kernal")
;; (semantic-add-system-include "/home/pan/thirdpart_head/boost" 'c++-mode)

;; (setq c-default-style "Google")
(setq-default tab-width 4)
;; open whitespace-mode
(global-set-key (kbd "C-c w") 'whitespace-mode)
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

;;(require 'clean-aindent-mode)
(add-hook 'prog-mode-hook 'clean-aindent-mode)
;; 自动清除多余空格，当触发保存文件
;;(add-hook 'c-mode-common-hook 'ws-butler-mode-hook)
(add-hook 'prog-mode-hook #'ws-butler-mode)

;;(require 'yasnippet)
;;(yas-global-mode 1)
;; Package: smartparens
;;(require 'smartparens-config)
;;(show-smartparens-global-mode +1)
;;(smartparens-global-mode 1)

;; when you press RET, the curly braces automatically
;; add another newline
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))
