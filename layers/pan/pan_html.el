;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; html/css
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; web-mode
;; (require 'clean-aindent-mode)
;; (require 'web-mode)
;; (require 'ac-html)
(setq web-mode-css-indent-offset 4)
(setq web-mode-code-indent-offset 4)
(setq web-mode-markup-indent-offset 4)
(setq web-mode-script-padding 4)
(setq web-mode-style-padding 4)
(setq web-mode-block-padding 4)
;; (setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-auto-closing t)
(setq web-mode-enable-auto-quoting t)
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-css-colorization t)
(setq web-mode-engines-alist '(("django" . "\\.html\\'")))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(define-key web-mode-map (kbd "C-x p") 'comment-or-uncomment-region)
(define-key web-mode-map (kbd "C-x \\") 'indent-region-or-buffer)
(define-key web-mode-map (kbd "C-c C-c")
  #'(lambda ()
      (interactive)
      (browse-url-of-file)))

;; company-web
;; (require 'company-web-html)
;; (add-hook 'web-mode-hook
;;             #'(lambda ()
;;                       (add-to-list 'company-backends '(company-web-html company-css))))

;; ac-html-csswatcher
;; (require 'ac-html-csswatcher)
;; (company-web-csswatcher-setup)

;; ac-html-bootstrap
;; (require 'ac-html-bootstrap)
;; (add-hook 'web-mode-hook 'company-web-bootstrap+)

;; emmet-mode
;; (require 'emmet-mode)

;; counsel-css
;; (require 'counsel-css)
;; (add-hook 'web-mode-hook 'counsel-css-imenu-setup)
;; (define-key web-mode-map (kbd "M-i") 'counsel-css)

;; rainbow-mode
;; (require 'rainbow-mode)

;; anjular-mode
;; (require 'ac-html-angular)
;; (require 'angular-mode)
;; (require 'angular-snippets)
