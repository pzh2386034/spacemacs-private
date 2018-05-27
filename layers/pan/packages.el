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
    flyspell
    yasnippet
    yasnippet-snippets
    swiper
    lispy
    counsel
    markdown-mode
    hungry-delete
    elpy
    )
  )
  "The list of Lisp packages required by the pan layer.

        recipe.  See: https://github.com/milkypostman/melpa#recipe-format"
  (defun pan/init-flyspell ()
    (use-package flyspell
      :init
      :defer t
      :bind)
    )

  (defun pan/init-swiper()
    (use-package swiper
      :init
      :defer t
      :bind)
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
 (global-set-key (kbd "s-r") 'nil)
 (defun pan/init-markdown-mode ()
  (use-package markdown-mode
    :init
    :config
    ;; (use-package moccur-edit)
;;    (unbind-key "M-n" markdown-next-link)
   :bind
   (
    ("s-r -" . org-ctrl-c-minus)
    ("s-r h" . markdown-insert-header)
    ("s-r 1" . markdown-insert-header-atx-1)
    ("s-r 2" . markdown-insert-header-atx-2)
    ("s-r 3" . markdown-insert-header-atx-3)
    ("s-r l" . markdown-insert-link-button)
    ("s-r u" . markdown-insert-uri)
    ("s-r t" . table-insert)
    ("s-r c" . markdown-insert-gfm-code-block)
    ("s-r q" . markdown-insert-blockquote)
    ("s-r q" . markdown-insert-blockquote)
    ("s-r i" . markdown-insert-italic)
    ("s-r b" . markdown-insert-bold))
   )
  )
(defun pan/init-yasnippet()
  (use-package yasnippet
    :defer t
    :init
    :bind (("C-x l" . yas-describe-tables)
           )
    )
  )
(defun pan/post-init-yasnippet ()
  (progn
    ;;(set-face-background 'secondary-selection "gray")
    (setq-default yas-prompt-functions '(yas-ido-prompt yas-dropdown-prompt))
    (spacemacs/add-to-hooks 'pan/load-yasnippet '(prog-mode-hook
                                                            markdown-mode-hook
                                                            org-mode-hook
                                                            c-mode-hook))
    )
  )

(defun pan/init-yasnippet-snippets()
  (use-package yasnippet-snippets
    :defer t
    :init
    ))
(defun pan/init-elpy ()
  (use-package elpy
    :defer t
    :init
    (elpy-enable)
    )
  )
(defun pan/init-fcitx ()
  (use-package fcitx
    :defer t
    :init
    (setq  fcitx-active-evil-states '(insert emacs hybrid))
    ))
)

;; load self define .el files
(add-to-list 'load-path "~/.spacemacs.d/layers/pan/")
(load "pan_org.el")
;;(load "pan_dired.el")
;;(load "pan_python.el")
;;(load "pan_tag.el")
;;(load "pan_c-c++.el")
;;(load "pan_ggtags.el")
;;(load "pan_yasnippet.el")

;;; packages.el ends here
