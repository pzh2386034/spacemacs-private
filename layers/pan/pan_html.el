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
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
;; (define-key web-mode-map (kbd "C-x p") 'comment-or-uncomment-region)
;; (define-key web-mode-map (kbd "C-x \\") 'indent-region-or-buffer)
;; (define-key web-mode-map (kbd "C-c C-c")
  ;; #'(lambda ()
  ;;     (interactive)
  ;;     (browse-url-of-file)))

(add-hook 'web-mode-hook
          (lambda ()
            (local-set-key (kbd "s-m e") 'web-mode-dom-errors-show)
            (local-set-key (kbd "s-m b") 'web-mode-element-beginning)
            (local-set-key (kbd "s-m c") 'web-mode-element-child)
            (local-set-key (kbd "s-m p") 'web-mode-element-parent)
            (local-set-key (kbd "s-m sn") 'web-mode-element-sibling-next)
            (local-set-key (kbd "s-m sp") 'web-mode-element-sibling-previous)
            (local-set-key (kbd "s-m x") 'web-mode-dom-xpath)
            (local-set-key (kbd "s-m o") 'web-mode-element-clone)
            (local-set-key (kbd "s-m d") 'web-mode-element-vanish)
            (local-set-key (kbd "s-m w") 'web-mode-element-wrap)
            (local-set-key (kbd "s-c f") 'web-mode-fold-or-unfold)
            (local-set-key (kbd "s-c u") 'web-mode-element-children-fold-or-unfold)
            (local-unset-key (kbd "s-g"))
            (local-unset-key (kbd "s-h"))
            (smartparens-mode)
            (set (make-local-variable 'company-minimum-prefix-length) 2)
            ))

(with-eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "s-c f") 'web-beautify-js))
(with-eval-after-load 'js
  '(define-key js-mode-map (kbd "s-c f") 'web-beautify-js))
(with-eval-after-load 'json-mode
  '(define-key json-mode-map (kbd "s-c f") 'web-beautify-js))
(with-eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))

(with-eval-after-load 'web-mode
  '(define-key web-mode-map (kbd "C-c b") 'web-beautify-html))

(with-eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))

(with-eval-after-load 'js2-mode
  '(add-hook 'js2-mode-hook
             (lambda ()
               (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

;; Or if you're using 'js-mode' (a.k.a 'javascript-mode')
(with-eval-after-load 'js
  '(add-hook 'js-mode-hook
             (lambda ()
               (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

(with-eval-after-load 'json-mode
  '(add-hook 'json-mode-hook
             (lambda ()
               (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

(with-eval-after-load 'sgml-mode
  '(add-hook 'html-mode-hook
             (lambda ()
               (add-hook 'before-save-hook 'web-beautify-html-buffer t t))))

(with-eval-after-load 'web-mode
  '(add-hook 'web-mode-hook
             (lambda ()
               (add-hook 'before-save-hook 'web-beautify-html-buffer t t))))

(with-eval-after-load 'css-mode
  '(add-hook 'css-mode-hook
             (lambda ()
               (add-hook 'before-save-hook 'web-beautify-css-buffer t t))))
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
