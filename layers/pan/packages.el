;;; packages.el --- pan layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: pan zehua <pan@pans-MacBook-Pro.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;

;;; Commentary:

;;; Code:

(defconst pan-packages
  '(
    ;; yasnippet-snippets
    swiper
    lispy
    counsel
    function-args
    cc-mode
    ;; helm-gtags
    ws-butler
    anaconda-mode
    company-irony
    irony
    flycheck-irony
    irony-eldoc
    dashboard
    ;; elpy
    web-beautify
    symbol-overlay
    emmet-mode
    )
  )
  "The list of Lisp packages required by the pan layer.

        recipe.  See: https://github.com/milkypostman/melpa#recipe-format"
(defun pan/init-emmet-mode()
  (use-package emmet-mode
    :init
    :ensure t
    :config))
(defun pan/init-web-beautify()
  (use-package web-beautify
    :init
    :ensure t
    :config
    )
)
(defun pan/init-dashboard()
  (use-package dashboard
    :init
    :ensure t
    :config
    (dashboard-setup-startup-hook)
    )
  )
  (defun pan/init-swiper()
    (use-package swiper
      :init
      :defer t
      :bind)
    )
(defun pan/init-anaconda-mode ()
  (use-package anaconda-mode-installation-directory
    :init
    :defer t
    :bind))
(defun pan/init-symbol-overlay()
  (use-package symbol-overlay
    :init
    :defer t
    :bind))
(defun pan/init-ws-butler ()
  (use-package ws-butler
    :init
    :defer t
    :bind))
(defun pan/init-cc-mode ()
  (use-package cc-mode
    :init
    :defer t
    :bind))

(defun pan/init-function-args ()
  (use-package function-args
    :init
    :defer t
    :bind))

(defun pan/init-helm-gtags()
  (use-package helm-gtags
    :init
    :defer t
     )
  )

  (defun pan/init-lispy()
    (use-package lispy
      :init
      :defer t
      :bind)
    )
  (defun pan/init-counsel()
    (use-package counsel
      :init
      :defer t
      :bind)
    )
  (defun pan/init-hungry-delete()
    (use-package hungry-delete
      :init
      :defer t
      :bind)
(defun pan/init-fcitx ()
  (use-package fcitx
    :defer t
    :init
    (setq  fcitx-active-evil-states '(insert emacs hybrid))
    ))
)
(defun pan/init-irony ()
  (use-package irony
    :defer t
    :init))

(defun pan/init-company-irony ()
  (use-package company-irony
    :defer t
    :init))
(defun pan/init-flycheck-irony ()
  (use-package flycheck-irony
    :defer t
    :init))
(defun pan/init-irony-eldoc ()
  (use-package irony-eldoc
    :defer t
    :init))
;; load self define .el files
(add-to-list 'load-path "~/.spacemacs.d/layers/pan/")
(load "pan_org.el")
(load "pan_dired.el")
(load "pan_python.el")
(load "pan_tag.el")
(load "pan_c-c++.el")
(load "pan_ggtags.el")
(load "pan_go.el")
(load "pan_yasnippet.el")
(load "pan_html.el")
;; (load "pan_irony.el")
(load "awesome-pair/awesome-pair.el")
(load "awesome-tab/awesome-tab.el")

  (awesome-tab-mode t)

;;; packages.el ends here
