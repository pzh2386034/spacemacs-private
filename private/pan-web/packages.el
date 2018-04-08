;;; packages.el --- web layer packages file for Spacemacs.
;;
;;; Code:

(defconst pan-web-packages
  '(
    clean-aindent-mode
    css-mode
    js2-mode
    json-mode
    web-mode
    angular-mode
    ac-html
    ac-html-angular
    web-completion-data
    company-web-html
    angular-snippets
  )
  )

(defun pan-web/init-web-mode ()
  (use-package web-mode
    :init
    :mode (("\\.erb\\'" . web-mode)
           ("\\.mustache\\'" . web-mode)
           ("\\.html?\\'" . web-mode)
           ("\\.eex\\'" . web-mode)
           ("\\.php\\'" . web-mode))
    :config
    ;; (add-hook 'web-mode-hook 'clean-aindent-mode)
  )
)
(defun pan-web/init-angular-mode ()
  (use-package angular-mode
    :init
    :defer t
  )
)
(defun pan-web/post-init-css-mode ()
  (progn
    (dolist (hook '(css-mode-hook sass-mode-hook less-mode-hook))
      (add-hook hook 'rainbow-mode))

    (defun css-imenu-make-index ()
      (save-excursion
        (imenu--generic-function '((nil "^ *\\([^ ]+\\) *{ *$" 1)))))

    (add-hook 'css-mode-hook
              (lambda ()
                (setq imenu-create-index-function 'css-imenu-make-index)))))
(add-hook 'web-mode-hook 'smartparens-mode)
;; (add-hook 'web-mode-hook 'clean-aindent-mode)
;; (add-hook 'web-mode-hook 'angular-mode)
;; (add-hook 'web-mode-hook 'css-mode)
(defun pan-web/post-init-web-mode ()
  (with-eval-after-load "web-mode"
    (web-mode-toggle-current-element-highlight)
    (web-mode-dom-errors-show))
  (add-hook 'web-mode-hook 'smartparens-mode)
  (setq company-backends-web-mode '((
                                     ;; ac-html
                                     ;; ac-html-angular
                                     company-dabbrev-code
                                     company-keywords
                                     company-etags
                                     company-files
                                     company-dabbrev))))

(defun pan-web/post-init-json-mode ()
  (add-to-list 'auto-mode-alist '("\\.tern-project\\'" . json-mode))
  (add-to-list 'auto-mode-alist '("\\.fire\\'" . json-mode))
  (add-to-list 'auto-mode-alist '("\\.fire.meta\\'" . json-mode))
  (spacemacs/set-leader-keys-for-major-mode 'json-mode
    "ti" 'my-toggle-web-indent))


(defun pan-web/post-init-clean-aindent-mode()
  (use-package clean-aindent-mode
    :defer t
    :init
    :config
    (clean-aindent-mode t)
    (set 'clean-aindent-is-simple-indent t)
    (defun my-pkg-init()
      (electric-indent-mode -1)  ; no electric indent, auto-indent is sufficient
      (clean-aindent-mode t)
      (setq clean-aindent-is-simple-indent t)
      (define-key global-map (kbd "RET") 'newline-and-indent))
    (add-hook 'after-init-hook 'my-pkg-init)
    ))

;; (defun pan/init-angular-snippets()
;;   (use-package angular-snippets
;;     :defer t
;;     :init
;;     ))
;; (defun pan/init-web-completion-data()
;;   (use-package web-completion-data
;;     :defer t
;;     :init
;;     ))
;; (defun pan/init-angular-mode()
;;   (use-package angular-mode
;;     :defer t
;;     :init
;;     ))

;;; packages.el ends here
