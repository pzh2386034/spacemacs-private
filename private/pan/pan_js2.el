;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; javascript
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; js2-mode
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(define-key js2-mode-map (kbd "C-x \\") 'indent-region-or-buffer)
(add-hook 'js2-mode-hook 'js2-imenu-extras-mode)

;; tide
(require 'tide)
(setq tide-format-options
      '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))
(add-hook 'js2-mode-hook 'tide-setup)

;; jquery-doc
(require 'jquery-doc)
(add-hook 'js2-mode-hook 'jquery-doc-setup)

;; flycheck
(add-hook 'js2-mode-hook
            #'(lambda ()
                      (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)
                            (if (member (current-filetype) '("html"))
                                  (evil-mode -1)
                              (flycheck-mode))))
